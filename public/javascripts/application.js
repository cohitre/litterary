$.initialize("#note-text", function(){
  var citationFormUrl = $("meta[name=new-citation]").attr('content');
  
  this.bind('textselect', function(event, string, element, range){
    
    
    if ( !range.isCollapsed ) {
      var offset = $(this).rangeOffset(range);
    
      $.facebox(function(){
        $.get(citationFormUrl, function(form){
          var self = $(form);
          self
            .find('#selected-text').text(string).end()
            .find('#citation_range_begin').val(offset.start).end()
            .find('#citation_range_end').val(offset.end);
          $.facebox(self);
        })
      });
    }
  });
});

$.initialize('.citation', function(){
  this
    .filter(function(){
      return $(this).attr('data-citations') !== "";
    })
    .each(function(index,item){
      $(item).addClass('note-color-'+index%8);
    });
})