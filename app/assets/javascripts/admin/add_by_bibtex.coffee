@bibtexModalInit = () ->
  $bibtexModal = $('#bibtex-modal')
  $entry  = $('#entry')

  # when the save modal button is pressed, submit the form
  document.getElementById('saveBibtexModalBtn').addEventListener 'click', ->
    document.getElementById('bibtex-form').submit()

  $bibtexModal.modal 'show'

  $bibtexModal.on 'shown.bs.modal', ->
    # initialize the preview variables
    $journalFields = $('#journal-fields')

    $previewTitle = document.getElementById('preview-journal-title')
    $previewJournalName = document.getElementById('preview-journal-name')
    $previewJournalVolume = document.getElementById('preview-journal-volume')
    $previewJournalIssue = document.getElementById('preview-journal-issue')
    $previewJournalPages = document.getElementById('preview-journal-pages')
    $previewJournalYear = document.getElementById('preview-journal-year')
    $previewJournalAuthors = document.getElementById('preview-journal-authors')

    document.getElementById('entry').addEventListener 'input', ->
      if this.value.length > 80
        citation =  doParse(this.value)
        if Object.keys(citation).length > 0
          this.style.border = "1px solid green"
          update_preview citation[Object.keys(citation)[0]]
        else
          this.style.border = "1px solid red"

    # function to update the preview when there is new input in the textarea
    update_preview = (citation) ->

      if citation.entryType == "ARTICLE"
        $journalFields.show()

        $previewTitle.innerHTML =  citation.TITLE
        $previewJournalName.innerHTML = citation.JOURNAL
        $previewJournalVolume.innerHTML = citation.VOLUME
        $previewJournalIssue.innerHTML = citation.NUMBER
        $previewJournalPages.innerHTML = citation.PAGES
        $previewJournalYear.innerHTML = citation.YEAR
        $previewJournalAuthors.innerHTML = citation.AUTHOR

        console.log citation
