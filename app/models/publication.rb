class Publication < ActiveRecord::Base
  default_scope { eager_load(:conference, :journal) }

  has_many :authors, dependent: :destroy
  has_many :people, {:through=>:authors, :source=>"person"}
  has_one :conference, dependent: :destroy
  has_one :journal, dependent: :destroy

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :people, allow_destroy: true
  accepts_nested_attributes_for :conference
  accepts_nested_attributes_for :journal

  validates :title, presence: true

  attr_reader :bibtex_entry

  require 'citeproc'
  require 'csl/styles'

  # return an array of the authors that are members
  def return_member_authors
    Publication.find_by_sql([
      "select * from authors, publications, people
      where authors.publication_id = publications.id and
      authors.person_id = people.id and
      publications.id = ? and
      authors.person_id in
        (select person_id from members)", self.id])
  end

  def return_unused_authors
    #Author.eager_load(:publication).where({ count.publication_id: self.id }: 0)
    #Publication.eager_load(:authors).where(self.authors)
    #Author.eager_load(:publication, :person, :members).group('person_id').having('count(person_id) = 1').where(publication_id: self.id).where(person: Member.all.people)
  end

  def type
    if self.conference
      "Conference"
    else
      "Journal"
    end
  end

  def cite
    array = []
    # sort the authors by priority
    sorted = self.authors.sort { |a,b| a.priority <=> b.priority }

    # format the authors in the appropriate style
    sorted.each do |au|
      array << "#{au.person.lastName}, #{au.person.firstName}"
    end
    authors = array.join(" and ")

    if self.journal
      entry  = BibTeX::Entry.new({
                            :bibtex_type => :article,
                            :author => "#{authors}",
                            :journal => "#{self.journal.title}",
                            :volume => "#{self.journal.volume}",
                            :number => "#{self.journal.issue}",
                            :title => "#{self.title}",
                            :pages => "#{self.pages}",
                            :date => "#{self.date}"
                        })
    else
      entry = BibTeX::Entry.new({
                            :bibtex_type => :inproceedings,
                            :author => "#{authors}",
                            :booktitle => "#{self.conference.name}",
                            :publisher => "#{self.conference.publisher}",
                            :place => "#{self.conference.location}",
                            :title => "#{self.title}",
                            :pages => "#{self.pages}",
                            :date => "#{self.date}"
                        })
    end
    return entry
  end

  def create_from_bibtex(bibtex_entry)
    entry = BibTeX.parse bibtex_entry

    ActiveRecord::Base.transaction do
      self.title = entry[0].title
      self.pages = entry[0].pages
      dateNew = Date.strptime(entry[0].year, '%Y')
      self.date = dateNew

      if entry[0].journal
        self.journal = Journal.new(title: entry[0].journal, volume: entry[0].volume, issue: entry[0].number)
      else
        self.conference = Conference.new(name: entry[0].booktitle)
        self.conference.publisher  = entry[0].publisher if entry[0].publisher
      end

      self.save

      entry[0].author.each_with_index do |a, index|
        person = Person.create(firstName: a.first, lastName: a.last)
        self.authors << Author.new(person_id: person.id, priority: index + 1)
      end
    end

  end

  def self.search(params)
    params.select { |k, v| v.present?}.reduce(all) do |scope, (key, value)|
      case key.to_sym
      when :keyword
        scope.where(["publications.title LIKE ?", "%#{value}%"])
      when :author
        # scope.where(author.person.full_name: "LIKE ?","%#{value}%")
        scope.joins(:people).where(["(people.lastName LIKE ?) OR (people.firstName LIKE ?)", "%#{value}%", "%#{value}%"])
      when :year
        if Rails.env.production?
          #this will NOT work on SQLite
          scope.where('extract(year from publications.date) = ?', value)
        else
          #this will work on SQLite ONLY
          scope.where("cast(strftime('%Y', date) as int) = ?", value)
        end
      else
        scope
      end
    end
  end
end
