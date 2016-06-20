class Journal < ActiveRecord::Base
  belongs_to :publication, inverse_of: :journal
  has_many :authors, through: :publication
  accepts_nested_attributes_for :publication

  validates :title, presence: true

  # def cite(authors)
  #   BibTeX::Entry.new({
  #                         :bibtex_type => :article,
  #                         :author => "#{authors}",
  #                         :journal => "#{self.title}",
  #                         :volume => "#{self.volume}",
  #                         :number => "#{self.issue}"#,
  #                         #:title => "#{self.publication.title}",
  #                         #:pages => "#{self.publication.pages}",
  #                         #:date => "#{self.publication.date}"
  #                     })
  # end
end
