jQuery.fn.rangeOffset = function(range){
  var contents = this.contents();
  var startOffset = contents.slice(0, contents.index(range.anchorNode));
  var endOffset = contents.slice(0, contents.index(range.focusNode));

  function addLengths(ar) {
    var total = 0;
    ar.each(function(){
      total += $(this).text().length;
    });
    return total;
  }
  
  return {
    start: addLengths(startOffset)+range.anchorOffset,
    end: addLengths(endOffset)+range.focusOffset
  }
  // $.each(contents, function(){
  //   console.log(this)
  // });
  // console.log(range);
}

$.initialize("#note-text", function(){
  this.bind('textselect', function(event, string, element, range){
    console.log($(this).rangeOffset(range));
  });
});