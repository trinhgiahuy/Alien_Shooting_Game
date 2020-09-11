<!--
areas = new Array();
scale = 1;

function areaString(scale) {
  str = "<area shape='rect' coords='";
  str += this.x1*scale + ",";
  str += this.y1*scale + ",";
  str += this.x2*scale + ",";
  str += this.y2*scale;
  str += "' title='" + this.title + "' ";
  if (this.enabled)
  {
      str += "href='javascript:parent.location.href=\"" + this.href + "\"'";
  }
  str += ">";
  return str;
}

function hotArea(x1, y1, x2, y2, href, title, enabled) {
  this.x1 = x1;
  this.y1 = y1;
  this.x2 = x2;
  this.y2 = y2;
  this.href = href;
  this.title = title;
  this.areaString = areaString;
  this.enabled = enabled;
}

function areaStringCircle(scale) {
  str = "<area shape='circle' coords='";
  str += this.x1*scale + ",";
  str += this.y1*scale + ",";
  str += this.radius*scale;
  str += "' href='javascript:parent.location.href=\"" + this.href + "\"' title='" + this.title + "'>";
  return str;
}

function hotAreaCircle(x1, y1, radius, href, title) {
  this.x1 = x1;
  this.y1 = y1;
  this.radius = radius;
  this.href = href;
  this.title = title;
  this.areaString = areaStringCircle;
}


function hdsImage(width, height, src, name) {
  this.x = 0;
  this.y = 40;
  this.width = width;
  this.height = height;
  this.src = src;
  this.name = name;
}

//-->

