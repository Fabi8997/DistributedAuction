
var timersArray = [];

function initializeTimersArray(){
    const timersElements = document.getElementsByClassName("timer");
    console.log(timersElements);
    for(var i = 0; i < timersElements.length; i++){
        timersArray[i] = timersElements.item(i);
    }
}

// Set the date we're counting down to
function startCountdown(countdownDate, timer) {

    var x = setInterval(function() {

        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countdownDate - now;

        // Time calculations for days, hours, minutes and seconds
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Output the result in an element with id="demo"
        timer.innerHTML = days + "d " + hours + "h "
            + minutes + "m " + seconds + "s ";

        if (distance < 120000) {
            timer.style.color = 'Orange';
        }

        if (distance < 30000) {
            timer.style.color = 'Red';
        }

        // If the count down is over, write some text
        if (distance < 0) {
            clearInterval(x);
            timer.innerHTML = "EXPIRED";
        }
    }, 1000);
}

function setTimers(timestampArray) {

    initializeTimersArray();

    for(let i = 0; i < timersArray.length; i++){
        console.log(timestampArray[i], new Date(timestampArray[i]).getTime());
            startCountdown(new Date(timestampArray[i]).getTime(), timersArray[i]);
    }
}

function setTimer(countdownDate){
    startCountdown(new Date(countdownDate).getTime(),document.getElementById("timer"));
}