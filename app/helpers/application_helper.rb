module ApplicationHelper

  def generate_citations(publications, style)

    bib = BibTeX::Bibliography.new

    publications.each do |pub|
      bib << pub.cite
    end

    cp = CiteProc::Processor.new style: "#{style}", format: 'text'
    citation_list = []

    cp.import bib.to_citeproc
    if style == "ieee"
      cp.bibliography.references.each do |ref|
        citation_list << ref.to_s[3..-1]
      end
    else
      cp.bibliography.references.each do |ref|
        citation_list << ref.to_s
      end
    end

    return citation_list
  end

end
