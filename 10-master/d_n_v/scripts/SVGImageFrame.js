<!--

function goback() {
   parent.history.back();
}

function goforward() {
   parent.history.forward();
}

function zoomin() {
   if (scale < 1) {
      scale *= 2;
   } else {
      scale += 1;
   }
   return true;
}

function zoomout() {
   if (scale <= 1) {
      scale /= 2;
   } else {
      scale -= 1;
   }
   return true;
}

function viewall() {
   scale = 1;
   return true;
}

function getOpenupUrl() {
   var url = top.fixPath(location.pathname);
   url = url.replace(/ContentFrame\d/, '');  // remove any ContentFame0 etc
   var eID = top.menu.theMenu.findEntry(url, "url", "right");
   if (eID == -1) {
      // This may be a concurrent state/flow diagram, so look for the default
      // view name form
      var pArray = url.split("/");
      pArray = pArray.slice(pArray.length-3, pArray.length-1);
      url = pArray.join("/");
      eID = top.menu.theMenu.findEntry(url, "url", "contains");
   }
   if (eID == -1) {
      return "";
   }
   var pID = top.menu.theMenu.entry[eID].parent;

   if (pID > -1 && top.menu.theMenu.entry[pID].url != '') {
      return top.menu.theMenu.entry[pID].url;
   }
   return "";
}

/*
function openupMachineName() {
   var url = top.fixPath(location.pathname);
   var pArray = url.split("/");

   // file name is the last element of this array
   var filename = pArray[pArray.length - 1];
   pArray = pArray.slice(pArray.length-3, pArray.length-1);
   url = pArray.join("/");

   var finish = false;
   var menuIndex = -1;
   while (finish == false)
   {
      // split the file name up and remove the last bit
      var machineArray = filename.split("_");
      if (machineArray.length == 1) {
         // we've run out of bits - give up
         finish = true;
      }
      else {
         machineArray = machineArray.slice(0, machineArray.length-1);

         // now put it all back together to find the parent url
         var filename = machineArray.join("_");
         var newurl = url + "/" + filename;
         eID = top.menu.theMenu.findEntry(newurl, "url", "contains");

         if (eID != -1) {
            finish = true;
         }
      }
   }
   if (eID != -1 && top.menu.theMenu.entry[eID].url != '') {
      parent.location.href = '../../' + top.menu.theMenu.entry[eID].url;
   }
   return true;
}
*/

// open up using only the machine name.
// This is for views that do not appear in the menu list but are not top level
function openupMachineName() {
   var url = top.fixPath(location.pathname);
   var pArray = url.split("/");

   // file name is the last element of this array
   var filename = pArray[pArray.length - 1];
   pArray = pArray.slice(0, pArray.length-1);
   url = pArray.join("/");

   // split the file name up and remove the last bit
   var machineArray = filename.split("_");
   machineArray = machineArray.slice(0, machineArray.length-1);

   // now put it all back together to find the parent url
   var newname = machineArray.join("_");
   var newurl = url + "/" + newname + ".htm";

   parent.location.href = newurl;
   return true;
}

function openupGraphical() {
   var url = getOpenupUrl();
   if (url == "") {
      return true;
   }

   parent.location.href = '../../' + url;
}

function openupText() {
   var url = getOpenupUrl();
   if (url == "") {
      return true;
   }

   parent.location.href = '../' + url;
}

function changeSVG(newSVG) {
   document.getElementById('SVGID').SRC = newSVG;
}

var zoomable = true;
var zoomed = false;
if (is.nav6) {
   zoomable = false;
} else {
  if (is.major >= 4) {
      document.write("<DIV ID='elZoom' STYLE='position: absolute; visibility: hidden;'></DIV>");
  }
}

//-->

