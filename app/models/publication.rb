class Publication < ActiveRecord::Base
  has_many :authors, dependent: :destroy
  has_many :people, {:through=>:authors, :source=>"person"}
  has_one :conference, dependent: :destroy
  has_one :journal, dependent: :destroy

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :people, allow_destroy: true
  accepts_nested_attributes_for :conference
  accepts_nested_attributes_for :journal

  validates :title, presence: true

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

  def return_authors_only_in_this_publication

  end

  def type
    if self.conference
      "Conference"
    else
      "Journal"
    end
  end

  def cite(style)
    array = []
    # sort the authors by priority
    authors_sorted = self.authors.sort { |a,b| a.priority <=> b.priority }

    # format the authors in the appropriate style
    authors_sorted.each do |au|
      array << "#{au.person.lastName}, #{au.person.firstName}"
    end
    authors = array.join(" and ")

    cp = CiteProc::Processor.new style: "#{style}", format: 'text'
    bib = BibTeX::Bibliography.new

    if self.conference
      bib << self.conference.cite(authors)
    else
      bib << self.journal.cite(authors)
    end

    cp.import bib.to_citeproc
    ref = cp.bibliography.references[0].to_s
    ref = ref[3..-1] if ref.start_with?('[')
    ref
  end
end
