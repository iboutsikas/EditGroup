tinymce.PluginManager.add("anchor",function(a){function b(){var b=a.selection.getNode(),c="",d="A"==b.tagName&&""===a.dom.getAttrib(b,"href");d&&(c=b.name||b.id||""),a.windowManager.open({title:"Anchor",body:{type:"textbox",name:"name",size:40,label:"Name",value:c},onsubmit:function(c){var e=c.data.name;d?b.id=e:(a.selection.collapse(!0),a.execCommand("mceInsertContent",!1,a.dom.createHTML("a",{id:e})))}})}a.addCommand("mceAnchor",b),a.addButton("anchor",{icon:"anchor",tooltip:"Anchor",onclick:b,stateSelector:"a:not([href])"}),a.addMenuItem("anchor",{icon:"anchor",text:"Anchor",context:"insert",onclick:b})});