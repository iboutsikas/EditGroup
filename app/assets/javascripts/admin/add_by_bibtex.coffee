@bibtexModalInit = () ->
  $bibtexModal = $('#bibtex-modal')

  # when the save modal button is pressed, submit the form
  document.getElementById('saveBibtexModalBtn').addEventListener 'click', ->
    $('form#bibtex-form').trigger('submit.rails');

  $bibtexModal.modal 'show'

  $bibtexModal.on 'shown.bs.modal', ->
    $entry  = document.getElementById('entry')
    $entry.focus()

    # initialize the preview variables
    $journalFields = $('#journal-fields')
    $conferenceFields = $('#conference-fields')
    $failMessage = document.getElementById('bibtex-fail-message')

    $previewJournalTitle = document.getElementById('preview-journal-title')
    $previewConferenceTitle = document.getElementById('preview-conference-title')
    $previewJournalPages = document.getElementById('preview-journal-pages')
    $previewConferencePages = document.getElementById('preview-conference-pages')
    $previewJournalYear = document.getElementById('preview-journal-year')
    $previewConferenceYear = document.getElementById('preview-conference-year')
    $previewJournalAuthors = document.getElementById('preview-journal-authors')
    $previewConferenceAuthors = document.getElementById('preview-conference-authors')
    $previewJournalName = document.getElementById('preview-journal-name')
    $previewConferenceName = document.getElementById('preview-conference-name')
    $previewJournalVolume = document.getElementById('preview-journal-volume')
    $previewJournalIssue = document.getElementById('preview-journal-issue')

    $entry.addEventListener 'input', ->
      if this.value.length > 80
        citation =  doParse(this.value)
        if Object.keys(citation).length > 0
          this.style.border = "1px solid green"
          $failMessage.style.display = 'none'
          update_preview citation[Object.keys(citation)[0]]
        else
          this.style.border = "1px solid red"
          $failMessage.style.display  = 'block'
          $journalFields.hide()
          $conferenceFields.hide()

    # function to update the preview when there is new input in the textarea
    update_preview = (citation) ->

      if citation.entryType == "ARTICLE"

        $previewJournalTitle.innerHTML =  citation.TITLE
        $previewJournalPages.innerHTML = citation.PAGES
        $previewJournalYear.innerHTML = citation.YEAR
        $previewJournalAuthors.innerHTML = citation.AUTHOR
        $previewJournalName.innerHTML = citation.JOURNAL
        $previewJournalVolume.innerHTML = citation.VOLUME
        $previewJournalIssue.innerHTML = citation.NUMBER

        $journalFields.show()

      else
        $previewConferenceTitle.innerHTML =  citation.TITLE
        $previewConferenceName.innerHTML = citation.BOOKTITLE
        $previewConferencePages.innerHTML = citation.PAGES
        $previewConferenceYear.innerHTML = citation.YEAR
        $previewConferenceAuthors.innerHTML = citation.AUTHOR

        $conferenceFields.show()
