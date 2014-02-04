 $(function(){
    $('body').on('keypress', function(e){
        if (e.which == 13) {
            $.ajax({
                url: '/test',
                method: 'post',
                dataType: 'json',
                data: { genre: $('#genre').val(), city: $('#city').val() }
            })
            .success( function(data){
                console.log(data);
 
                for (var i=0;i<10;i++){
                    var foo = $('<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/' + data[i].id +'&color=01DFA5&show_comments=false&show_artwork=true&show_playcount=false&liking=false&theme_color=01DFA5&sharing=false&buying=false&show_user=false&show_artwork=false"></iframe>');
                    $('#ul').append($('#player'));
                    $('#ul').append('<img src="' + data[i].waveform_url + '">')
                }
            })
        }
    })
    $('#myspan').toggleClass('glyphicon-heart-empty glyphicon-heart')
  });


  