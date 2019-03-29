<!--
var nd, mo, y, da;
nd=new Date();
mo=nd.getMonth()+1;
y=nd.getYear();
if(y<80)y+=2000;
if(y>=80&y<=138)y+=1900;
da=nd.getDay();
document.write("<font LANG='ZH-CN' color=#FFFF99>"+y+"年"+mo+"月"+nd.getDate()+"日 "+"</font> ");

//time
document.write("<span id='Clock' style='font-size:12px; color=#FFFF999'></span>");

var wee;
wee=new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
document.write("<font color=#FFFF99>"+wee[da]+"</font> ");

//time
document.write("<span id='Clock' style='font-size:12px; color=#FFFF99'></span>");

//-->