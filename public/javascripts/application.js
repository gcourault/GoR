// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// JS del menu
function Browser() {
  var ua, s, i;
  this.isIE    = false;  
  this.isNS    = false;  
  this.version = null;
  ua = navigator.userAgent;
  s = "MSIE";
  if ((i = ua.indexOf(s)) >= 0) {
    this.isIE = true;
    this.version = parseFloat(ua.substr(i + s.length));
    return;
  }
  s = "Netscape6/";
  if ((i = ua.indexOf(s)) >= 0) {
    this.isNS = true;
    this.version = parseFloat(ua.substr(i + s.length));
    return;
  }
  // Treat any other "Gecko" browser as NS 6.1.
  s = "Gecko";
  if ((i = ua.indexOf(s)) >= 0) {
    this.isNS = true;
    this.version = 6.1;
    return;
  }
}
var browser = new Browser();
//----------------------------------------------------------------------------
// Code for handling the menu bar and active button.
//----------------------------------------------------------------------------
var activeButton = null;
// Capture mouse clicks on the page so any active button can be
// deactivated.
if (browser.isIE)
  document.onmousedown = pageMousedown;
else
  document.addEventListener("mousedown", pageMousedown, true);
function pageMousedown(event) {
  var el;
  if (activeButton == null)
    return;
  if (browser.isIE)
    el = window.event.srcElement;
  else
    el = (event.target.tagName ? event.target : event.target.parentNode);
  if (el == activeButton)
    return;
  if (getContainerWith(el, "DIV", "menu") == null) {
    resetButton(activeButton);
    activeButton = null;
  }
}
function buttonClick(event, menuId) {
  var button;
  if (browser.isIE)
    button = window.event.srcElement;
  else
    button = event.currentTarget;
  button.blur();
  if (button.menu == null) {
    button.menu = document.getElementById(menuId);
    menuInit(button.menu);
  }
  if (activeButton != null)
    resetButton(activeButton);
  if (button != activeButton) {
    depressButton(button);
    activeButton = button;
  }
  else
    activeButton = null;
  return false;
}
function buttonMouseover(event, menuId) {
  var button;
  if (browser.isIE)
    button = window.event.srcElement;
  else
    button = event.currentTarget;
  if (activeButton != null && activeButton != button)
    buttonClick(event, menuId);
}
function depressButton(button) {
  var x, y;
  button.className += " menuButtonActive";
  x = getPageOffsetLeft(button);
  y = getPageOffsetTop(button) + button.offsetHeight;
  if (browser.isIE) {
    x += button.offsetParent.clientLeft;
    y += button.offsetParent.clientTop;
  }
  button.menu.style.left = x + "px";
  button.menu.style.top  = y + "px";
  button.menu.style.visibility = "visible";
}
function resetButton(button) {
  removeClassName(button, "menuButtonActive");
  if (button.menu != null) {
    closeSubMenu(button.menu);
    button.menu.style.visibility = "hidden";
  }
}
function menuMouseover(event) {
  var menu;
  if (browser.isIE)
    menu = getContainerWith(window.event.srcElement, "DIV", "menu");
  else
    menu = event.currentTarget;
  if (menu.activeItem != null)
    closeSubMenu(menu);
}
function menuItemMouseover(event, menuId) {
  var item, menu, x, y;
  if (browser.isIE)
    item = getContainerWith(window.event.srcElement, "A", "menuItem");
  else
    item = event.currentTarget;
  menu = getContainerWith(item, "DIV", "menu");
  if (menu.activeItem != null)
    closeSubMenu(menu);
  menu.activeItem = item;
  item.className += " menuItemHighlight";
  if (item.subMenu == null) {
    item.subMenu = document.getElementById(menuId);
    menuInit(item.subMenu);
  }
  x = getPageOffsetLeft(item) + item.offsetWidth;
  y = getPageOffsetTop(item);
  var maxX, maxY;
  if (browser.isNS) {
    maxX = window.scrollX + window.innerWidth;
    maxY = window.scrollY + window.innerHeight;
  }
  if (browser.isIE && browser.version < 6) {
    maxX = document.body.scrollLeft + document.body.clientWidth;
    maxY = document.body.scrollTop  + document.body.clientHeight;
  }
  if (browser.isIE && browser.version >= 6) {
    maxX = document.documentElement.scrollLeft + document.documentElement.clientWidth;
    maxY = document.documentElement.scrollTop  + document.documentElement.clientHeight;
  }
  maxX -= item.subMenu.offsetWidth;
  maxY -= item.subMenu.offsetHeight;
  if (x > maxX)
    x = Math.max(0, x - item.offsetWidth - item.subMenu.offsetWidth
      + (menu.offsetWidth - item.offsetWidth));
  y = Math.max(0, Math.min(y, maxY));
  item.subMenu.style.left = x + "px";
  item.subMenu.style.top  = y + "px";
  item.subMenu.style.visibility = "visible";
  if (browser.isIE)
    window.event.cancelBubble = true;
  else
    event.stopPropagation();
}
function closeSubMenu(menu) {
  if (menu == null || menu.activeItem == null)
    return;
  if (menu.activeItem.subMenu != null) {
    closeSubMenu(menu.activeItem.subMenu);
    menu.activeItem.subMenu.style.visibility = "hidden";
    menu.activeItem.subMenu = null;
  }
  removeClassName(menu.activeItem, "menuItemHighlight");
  menu.activeItem = null;
}
function menuInit(menu) {
  var itemList, spanList
  var textEl, arrowEl;
  var itemWidth;
  var w, dw;
  var i, j;
  if (browser.isIE) {
    menu.style.lineHeight = "2.5ex";
    spanList = menu.getElementsByTagName("SPAN");
    for (i = 0; i < spanList.length; i++)
      if (hasClassName(spanList[i], "menuItemArrow")) {
        spanList[i].style.fontFamily = "Webdings";
        spanList[i].firstChild.nodeValue = "4";
      }
  }
  itemList = menu.getElementsByTagName("A");
  if (itemList.length > 0)
    itemWidth = itemList[0].offsetWidth;
  else
    return;
  for (i = 0; i < itemList.length; i++) {
    spanList = itemList[i].getElementsByTagName("SPAN")
    textEl  = null
    arrowEl = null;
    for (j = 0; j < spanList.length; j++) {
      if (hasClassName(spanList[j], "menuItemText"))
        textEl = spanList[j];
      if (hasClassName(spanList[j], "menuItemArrow"))
        arrowEl = spanList[j];
    }
    if (textEl != null && arrowEl != null)
      textEl.style.paddingRight = (itemWidth 
        - (textEl.offsetWidth + arrowEl.offsetWidth)) + "px";
  }
  if (browser.isIE) {
    w = itemList[0].offsetWidth;
    itemList[0].style.width = w + "px";
    dw = itemList[0].offsetWidth - w;
    w -= dw;
    itemList[0].style.width = w + "px";
  }
}
function getContainerWith(node, tagName, className) {
  while (node != null) {
    if (node.tagName != null && node.tagName == tagName &&
        hasClassName(node, className))
      return node;
    node = node.parentNode;
  }
  return node;
}
function hasClassName(el, name) {
  var i, list;
  list = el.className.split(" ");
  for (i = 0; i < list.length; i++)
    if (list[i] == name)
      return true;
  return false;
}
function removeClassName(el, name) {
  var i, curList, newList;
  if (el.className == null)
    return;
  newList = new Array();
  curList = el.className.split(" ");
  for (i = 0; i < curList.length; i++)
    if (curList[i] != name)
      newList.push(curList[i]);
  el.className = newList.join(" ");
}
function getPageOffsetLeft(el) {
  var x;
  x = el.offsetLeft;
  if (el.offsetParent != null)
    x += getPageOffsetLeft(el.offsetParent);
  return x;
}
function getPageOffsetTop(el) {
  var y;
  y = el.offsetTop;
  if (el.offsetParent != null)
    y += getPageOffsetTop(el.offsetParent);
  return y;
}
//hasta aca JS Menu


// <!--permitir solo ingreso de numeros -->

//<script type="text/javascript">
var nav4 = window.Event ? true : false;
function IsNumber(evt){
// Backspace = 8, Enter = 13, ‘0′ = 48, ‘9′ = 57, ‘.’ = 46
var key = nav4 ? evt.which : evt.keyCode;
//return (key <= 13 || (key >= 48 && key <= 57) || key == 46);
return (key <= 13 || (key >= 48 && key <= 57));
}

var nav4 = window.Event ? true : false;
function IsNumberdecimal(evt){
// Backspace = 8, Enter = 13, ‘0′ = 48, ‘9′ = 57, ‘.’ = 46
var key = nav4 ? evt.which : evt.keyCode;
//return (key <= 13 || (key >= 48 && key <= 57) || key == 46);
return (key <= 13 || (key >= 48 && key <= 57) || key == 46);
}
//</script>

//funtion para sumar de pagocompra new y edit
function tot(f) {
var efectivo = document.getElementsByName("pagocompra[pcpr_efectivo]"); 
var cheque = document.getElementsByName("pagocompra[pcpr_cheque]"); 
var depo = document.getElementsByName("pagocompra[pcpr_depotransf]"); 
var otro = document.getElementsByName("pagocompra[pcpr_otro]"); 
var tot = 0;
var totalr = document.getElementsByName("total");
 if (parseFloat(efectivo[0].value) > 0) {
   tot+=parseFloat(efectivo[0].value);
}
 if (parseFloat(cheque[0].value) > 0) {
   tot+=parseFloat(cheque[0].value);
}
 if (parseFloat(depo[0].value) > 0) {
   tot+=parseFloat(depo[0].value);
}
 if (parseFloat(otro[0].value) > 0) {
   tot+=parseFloat(otro[0].value);
}
totalr[0].value = Number(tot).toFixed(2);
}
//funcion expander

function muestra_oculta(id){
if (document.getElementById){ //se obtiene el id
var el = document.getElementById(id); //se define la variable "el" igual a nuestro div
var img = document.getElementById(el.id + 'img');

el.style.display = (el.style.display == 'none') ? 'block' : 'none'; //damos un atributo display:none que oculta el div
img.src = (img.src == 'minimize.png') ? 'maximize.png' : 'minimize.png';
}
}
window.onload = function(){/*hace que se cargue la función lo que predetermina que div estará oculto hasta llamar a la función nuevamente*/
muestra_oculta('contenido_a_mostrar');/* "contenido_a_mostrar" es el nombre que le dimos al DIV */
}

/* expander para el arbol de plandecuentas */ 
function show_type(div_to_show){
	if (document.getElementById){
		obj = document.getElementById(div_to_show);
		if (obj.style.display == "none"){
				obj.style.display = "";
				document.getElementById('img' + div_to_show).setAttribute("src", "/images/minimize.png");
		} else {
				obj.style.display = "none";
				document.getElementById('img' + div_to_show).setAttribute("src", "/images/maximize.png");
		}
	}
}


function init()
{ parent.location.reload(); }

function sumacauc(f)
{
var nums =  $$('input[type=checkbox]');
//var nums = f.num;
//var nums = document.getElementsByTagName("input"); 
var ntext = f.numtext;
var result = 0;
var resultfinal = 0;
var j = 0;
var largo = (nums.length+1);
for(var i=0;i<nums.length;i++) {
 if (i==0){ j=i;}
 else { j=(i);
 }
 if(nums[i].checked){
 result+=parseFloat(ntext[j].value);
 }
}
//f.answer.value=result;
resultfinal = (result)
f.answer.value=Number(resultfinal).toFixed(2);
}

//funciones de new cabcompras
function total(f) {
var totalrenglon = new Array();
var totalrenglon = document.getElementsByName("rencompras[rcom_totalrenglon][]"); 
var rengivaalic = document.getElementsByName("rencompras[aiva_alicuota[]]"); 
var rengneto = document.getElementsByName("rencompras[rcom_netorenglon][]"); 
var rengiva = document.getElementsByName("rencompras[rcom_ivarenglon][]"); 

var exc = document.getElementsByName("cabcompra[ccom_exento]");
var netgra = document.getElementsByName("cabcompra[ccom_netogravado]");
var iv = document.getElementsByName("cabcompra[ccom_iva]");
var tot = document.getElementsByName("cabcompra[ccom_total]");

var periva = document.getElementsByName("cabcompra[ccom_percepcioniva]");
var retiva = document.getElementsByName("cabcompra[ccom_retencioniva]");
var retgan = document.getElementsByName("cabcompra[ccom_retencionganancia]");
var retib = document.getElementsByName("cabcompra[ccom_retencionib]");
var perib = document.getElementsByName("cabcompra[ccom_percepcionib]");
var ngrav = document.getElementsByName("cabcompra[ccom_nogravado]");
var rmun = document.getElementsByName("cabcompra[ccom_retencionmunicipal]");
var iint = document.getElementsByName("cabcompra[ccom_impuestointerno]");

var totaltodo = 0;
var totaltodocab = 0;
var totreng = 0
var totaliva = 0;
var totalneto = 0;
var totalexec = 0;

var pi = 0;
var ri = 0;
var rg = 0;
var rib = 0;
var pib = 0;
var ng = 0;
var rm = 0;
var ii = 0;

var totalr = document.getElementsByName("ccom_total"); 
 for(var i=0;i<totalrenglon.length;i++) {
   totreng+=parseFloat(totalrenglon[i].value);
   totaliva+=parseFloat(rengiva[i].value);
   if (parseFloat(rengivaalic[i].value) == 0) {
    totalexec+=parseFloat(rengneto[i].value);
   }
   else {
    totalneto+=parseFloat(rengneto[i].value);
   }
 }
if (totalexec > 0) {
exc[0].value = Number(totalexec).toFixed(2);
}
if (totalneto > 0) {
netgra[0].value = Number(totalneto).toFixed(2);
}
if (totaliva > 0) {
iv[0].value = Number(totaliva).toFixed(2);
}
if (totalneto > 0 || totalexec > 0 || totaliva > 0) {
totaltodo = (totalneto + totalexec + totaliva) }
   
if (parseFloat(periva[0].value) > 0) {
 pi=parseFloat(periva[0].value);
}
if (parseFloat(retiva[0].value) > 0) {
 ri=parseFloat(retiva[0].value);
}
if (parseFloat(retgan[0].value) > 0) {
 rg=parseFloat(retgan[0].value);
}
if (parseFloat(retib[0].value) > 0) {
 rib=parseFloat(retib[0].value);
}
if (parseFloat(perib[0].value) > 0) {
 pib=parseFloat(perib[0].value);
}
if (parseFloat(ngrav[0].value) > 0) {
 ng=parseFloat(ngrav[0].value);
}
if (parseFloat(rmun[0].value) > 0) {
 rm=parseFloat(rmun[0].value);
}
if (parseFloat(iint[0].value) > 0) {
 ii=parseFloat(iint[0].value);
}
//alert(Number(pi).toFixed(2));

totaltodo += (pi + ri + rg + rib + pib + ng + rm + ii);
totaltodocab += (pi + ri + rg + rib + pib + rm );

tot[0].value = Number(totaltodo).toFixed(2);
}
//fin new cabcompras

//funciones renglon de compra
//funcion javascript para calcular los valores del iva y el total 
function calculate(fi)
{
var nums = new Array();
var iva = new Array();

var iva = document.getElementsByName("rencompras[aiva_alicuota[]]"); 
var nums = document.getElementsByName("rencompras[rcom_netorenglon][]"); 
var ivareng = document.getElementsByName("rencompras[rcom_ivarenglon][]"); 
var totalreng = document.getElementsByName("rencompras[rcom_totalrenglon][]"); 
var alicuota = document.getElementsByName("rencompras[alicuota][]"); 

for(var i=0;i<nums.length;i++) {
var ivar = 0;
var total = 0;
if (parseFloat(nums[i].value) > 0){
ivar+=((parseFloat(nums[i].value) * parseFloat(iva[i].value))/100);
total+=(parseFloat(nums[i].value) + ivar);
}

//alert(Number(ivar).toFixed(2));
//alert(Number(total).toFixed(2));
alicuota[i].value = Number(parseFloat(iva[i].value)).toFixed(2);
ivareng[i].value = Number(ivar).toFixed(2);
totalreng[i].value = Number(total).toFixed(2);
}
}

function calculaiva(fi)
{
var numis = new Array();
var numis = document.getElementsByName("rencompras[rcom_netorenglon][]"); 
var ivarengi = document.getElementsByName("rencompras[rcom_ivarenglon][]"); 
var totalrengi = document.getElementsByName("rencompras[rcom_totalrenglon][]"); 

for(var j=0;j<numis.length;j++) {
var ivari = 0;
var totali = 0;

ivari+=(parseFloat(ivarengi[j].value));
totali+=(parseFloat(numis[j].value) + ivari);

//alert(Number(ivar).toFixed(2));
//alert(Number(total).toFixed(2));

totalrengi[j].value = Number(totali).toFixed(2);
}
}
// fin rencompra



