var songs;
var play ="";
var combo_id;
var save_combos;

var audioView = function audioView() {
    var self = this;
    var id;
    var lastSong;
    var song;
    var track = 0;
    $('audio').remove();
    var audio = new Audio
    $('#player').append(audio)
    function newSong() {
        song = songs[track]
        lastSong=songs[track-1]
        audio.src = song.url;
        id = song.id;
        audio.play();
        audio.addEventListener("ended", function (){
            $("#current-heart").toggleClass("fa-heart-o", "fa-heart");
            track++;
            newSong();
        })
        $('#player').removeClass("hide");
        $('#art').empty();
        $('#art').attr('src', song.artwork_url);
        $('#song-info').empty();
        $('#song-info').text(song.name);
        if (lastSong == songs[-1]){
            $('#lastSong').empty();
        } else {
            $('#lastSong').empty();
            $('#lastSong').text(lastSong.name);
        }
    }
    $('#play').on('click', function(){
        audio.play();
    })
    $('#pause').on('click', function(){
        audio.pause();
    })
    $('#next').on('click', function() {
        if ( $('#current-heart').hasClass("fa-heart") == true ) {
            $('#last-heart').removeClass("fa-heart-o");
            $('#last-heart').addClass("fa-heart");
        } else {
            $('#last-heart').removeClass("fa-heart");
            $('#last-heart').addClass("fa-heart-o");
        }
        $('#current-heart').addClass("fa-heart-o");
        $('#current-heart').removeClass("fa-heart");
        
        track++;
        newSong();
    })
    $('#current-heart').on("click", function(){
        if ($('#current-heart').hasClass('fa-heart-o') == true) {
            $('#current-heart').removeClass("fa-heart-o");
            $('#current-heart').addClass("fa-heart");
        } else {
            $('#current-heart').removeClass("fa-heart");
            $('#current-heart').addClass("fa-heart-o");
        }
       
        $.ajax({
            url: "/liked",
            method: "POST",
            dataType: 'json',
            data: { song_id: song.id}
        })
    }); 

    $('#last-heart').on("click", function(){
        if ($('#last-heart').hasClass('fa-heart-o') == true) {
            $('#last-heart').removeClass("fa-heart-o");
            $('#last-heart').addClass("fa-heart");
        } else {
            $('#last-heart').removeClass("fa-heart");
            $('#last-heart').addClass("fa-heart-o");
        }
        $.ajax({
            url: "/liked",
            method: "POST",
            dataType: 'json',
            data: { song_id: lastSong.id}
        })
    }); 

    $('#combolike').on("click", function(){
        $('#combolike').toggleClass("fa-heart-o", "fa-heart");
        $.ajax({
            url: "/favorite",
            method: "POST",
            dataType: 'json',
            data: { combo_id: combo_id}
        })
    });

    newSong();
}


 $(function(){
    $.ajax({
        url: '/comboserve',
        method: 'GET',
        dataType: 'json'
    })
    .success( function(data){
        save_combos = data;
        console.log(data);
    })
            
    $('body').on('keypress', function(e){
        if (e.which == 13) {
            serve();
        }
    })
})  

//             $.ajax({
//                 url: '/save',
//                 method: 'POST',
//                 dataType: 'json',
//                 data: { genre: $('#genre').val(), city: $('#city').val() }
//             })
//             .success( function(data){
//                 combo_id = data.combo_id;
//             })
//             $.ajax({
//                 url: '/serve',
//                 method: 'POST',
//                 dataType: 'json',
//                 data: { genre: $('#genre').val(), city: $('#city').val() }
//             })
//             .success( function(data){
//                 console.log(data);
//                 songs = data
//                 new audioView();
//             })


/// AJAX CALLS ///
 // var save = function save(){
 //    $.ajax({
 //        url: '/save',
 //        method: 'POST',
 //        dataType: 'json',
 //        data: { genre: $('#genre').val(), city: $('#city').val() }
 //        })
 //    .success (function(data){
 //    console.log(data);
 //    songs = 

 //    })
 // }


var serve = function serve(){
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
}
