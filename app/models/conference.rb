class Conference < ActiveRecord::Base
  belongs_to :publication, inverse_of: :conference
  has_many :authors, through: :publication
  accepts_nested_attributes_for :publication

  validates :name, presence: true

  # def cite(authors)
  #   BibTeX::Entry.new({
  #                         :bibtex_type => :inproceedings,
  #                         :author => "#{authors}",
  #                         :booktitle => "#{self.name}",
  #                         :publisher => "#{self.publisher}",
  #                         :place => "#{self.location}"#,
  #                         #:title => "#{self.publication.title}",
  #                         #:pages => "#{self.publication.pages}",
  #                         #:date => "#{self.publication.date}"
  #                     })
  # end
end
