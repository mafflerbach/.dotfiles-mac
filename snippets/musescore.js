
var foo=document.querySelectorAll("#jmuse-scroller-component div.BmIOX img")
let wget=""
let i=0
foo.forEach((elem) => {

  wget+="curl \"" + elem.getAttribute("src") + "\" -o score_"+i+".svg; inkscape -h 3508 -w 2480 score_"+i+".svg -o score_"+i+".png\n";
  i=i+1
});


console.log(wget)
