$(document).on('shown.bs.modal', function () {
    tinyMCE.init({
        selector: "#tinymceArea",
        width: '100%',
        height: 220,
        plugins: ["image save media code link textcolor charmap wordcount searchreplace"],
        statusbar: true,
        menubar: false,
        link_assume_external_targets: true,
        toolbar1: "save | formatselect fontselect fontsizeselect | bold italic underline strikethrough  | alignleft aligncenter alignright alignjustify",
        toolbar2: "searchreplace | bullist numlist | link unlink anchor image media code | forecolor backcolor | subscript superscript | charmap | undo redo",
        toolbar_items_size: 'small',
        setup: function (editor) {
            editor.on('change', function () {
                tinyMCE.triggerSave();
                if (this.getContent() === "") {
                  toggleSubmitButton(false);
                } else {
                  toggleSubmitButton(true);
                }

            });
        },
        save_onsavecallback: function () { console.log('Saved'); }
    });
});

$(document).on('hide.bs.modal', function () {
    tinyMCE.editors=[];
});
