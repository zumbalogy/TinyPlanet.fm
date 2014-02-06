var songs;

var audioView = function audioView() {
    var self = this;
    var track = 0;
    var audio = new Audio;

        function newSong() {
            var song = songs[track];
            audio.src = song.url;
            audio.onload = function (){
                audio.play();
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



