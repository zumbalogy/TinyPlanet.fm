var songs;

var audioView = function audioView() {
    var self = this;
    var track = 0
    var audio = new Audio

        function newSong() {
            var song = songs[track]
            audio.src = song.url
            audio.onload = function (){
                audio.play()
            }
            audio.addEventListener("ended", function (){
                track++
                newSong();
            })
        }
    
    $('#play').on('click', function(){
        audio.play();
    })

    $('#pause').on('click', function(){
        audio.pause();
    })

    $('#next').on('click', function() {
        audio.setAttribute('src', songs[track+1].url)
        track++
        audio.load();
        audio.play();
    
    })
      $('#player').append(audio)
      newSong();
  }






 // function addSource(elem, path) {  
 //      $('<source>').attr('src', path).appendTo(elem);  
 //    }  

 $(function(){
    $('body').on('keypress', function(e){
        if (e.which == 13) {
            $.ajax({
                url: '/save',
                method: 'POST',
                dataType: 'json',
                data: { genre: $('#genre').val(), city: $('#city').val() }
            })
            .success( function(data){
                console.log(data); 

            })
            $.ajax({
                url: '/serve',
                method: 'POST',
                dataType: 'json',
                data: { genre: $('#genre').val(), city: $('#city').val() }
            })
            .success( function(data){
                console.log(data);
                songs = data
                new audioView();
              

                
                


            })

        };

        
    });

    $('like').on("click", function(){
        $.ajax({
            url: "/opinions",
            method: "POST",
            dataType: 'json',
            data: { song_id: 'song_id_goes_here'}

        })


    });

    
})   




// var audio = $('<audio>', {  
//   autoPlay : 'autoplay',  
//   controls : 'controls'  
// }); 
// audio.appendTo('player');
// addSource(audio, songs[0].url);

    //         for (var i=0;i<10;i++){
        //             var foo = $('<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/' + data[i].id +'&color=01DFA5&show_comments=false&show_artwork=true&show_playcount=false&liking=false&theme_color=01DFA5&sharing=false&buying=false&show_user=false&show_artwork=false"></iframe>');
        //             $('#ul').append($('#player'));
        //             $('#ul').append('<img src="' + data[i].waveform_url + '">')
        //         }
        //     })
        // }