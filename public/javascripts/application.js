// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function validate_fields( tag, id ){
    var s = document.getElementById(id);
    var elements = s.getElementsByTagName( tag );
    var flag=0;
    for(var i=0;i<elements.length;i++){
       if(elements[i].value== ""){flag=1; break;}
    }
    return flag;
}

function toggle_inline(id) {
    element = document.getElementById(id);
    if( element.style.display != 'none') {
        element.style.display = 'none';
    }
    else {
        element.style.display = '';
    }
}

//show spinner and hide spinner
function show_hide(e1,e2)
{
document.getElementById(e1).style.display = "inline";
document.getElementById(e2).style.display = "none";
}


                    
function submitform(url) {
  var form  = document.getElementById('page_section');
  var content = document.getElementById('content').value;
  form.setAttribute('action', url);
  form.setAttribute('scope', content);
  form.target = '_self';
  form.submit();
}

