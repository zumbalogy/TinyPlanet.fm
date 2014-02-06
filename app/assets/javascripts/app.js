var songs;

var audioView = function audioView() {
    var self = this;
    var id;
    var song;
    var track = 0;
    var audio = new Audio
    function newSong() {
        song = songs[track]
        audio.src = song.url;
        id = song.id;
        audio.onload = function (){
            audio.play()
        }
        audio.addEventListener("ended", function (){
            track++;
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
        audio.setAttribute('src', songs[track+1].url);
        track++;
        audio.load();
        audio.play();
    })
    $('#heart').on("click", function(){
        $.ajax({
            url: "/liked",
            method: "POST",
            dataType: 'json',
            data: { song_id: song.id}
        })
    }); 

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
})   



