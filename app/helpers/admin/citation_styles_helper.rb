module Admin::CitationStylesHelper

  def all_styles
    # order is important!
    citeproc_names = [ "ieee", "apa-5th-edition", "harvard-cite-them-right" ]
    display_names = [ "IEEE", "APA", "Harvard" ]
    Hash[citeproc_names.zip(display_names)]
  end

end