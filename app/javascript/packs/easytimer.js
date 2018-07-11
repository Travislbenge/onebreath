import Timer from 'easytimer'

function redirectToBreakNew(timer) {
  if(targetAchieved(timer)){
    const dataSetTimer = document.getElementById("timer2").dataset
    const idSession = dataSetTimer.sessionid
    const idBreak = dataSetTimer.break
    if (idBreak) {
      window.location.href = `/timer_sessions/${idSession}`
    } else {
      window.location.href =`/timer_sessions/${idSession}/breaks/new`
    }
  }

  // rediredctio to break new
}

function targetAchieved(timer) {
  const dataSetLimits = document.getElementById("timer2").dataset
  const focusLimit = dataSetLimits.limit
  const breakLimit = dataSetLimits.breaklimit
  console.log(timer.minutes)
  if (breakLimit) {
    return (timer.seconds === 0 && timer.minutes === 0) ? true : false;
  } else {
    return (timer.seconds === 0 && timer.minutes === 0) ? true : false;
  }
}

// function startTimerSession() {
//   const timer = new Timer();
//   timer.start();
//   timer.addEventListener('secondsUpdated', function (e) {
//     $('#timer').html(timer.getTimeValues().toString());


//   });
// }
// global.startTimerSession = startTimerSession



function countDownSession() {
  const dataSetTime = document.getElementById("timer2").dataset
  const workingDay = dataSetTime.day
  const timer = new Timer();
timer.start({countdown: true, startValues: {minutes: parseInt(workingDay)}});
$('#timer2').html(timer.getTimeValues().toString());
timer.addEventListener('secondsUpdated', function (e) {
    $('#timer2').html(timer.getTimeValues().toString());
    redirectToBreakNew(timer.getTimeValues())
});
}
global.countDownSession = countDownSession



// import Timer from 'easytimer'

// function redirectToBreakNew(timer) {
//   if(targetAchieved(timer)){
//     const dataSetTimer = document.getElementById("timer").dataset
//     const idSession = dataSetTimer.sessionid
//     const idBreak = dataSetTimer.break
//     if (idBreak) {
//       window.location.href = `/timer_sessions/${idSession}`
//     } else {
//       window.location.href =`/timer_sessions/${idSession}/breaks/new`
//     }
//   }

//   // rediredctio to break new
// }

// function targetAchieved(timer) {
//   const target = document.getElementById("timer").dataset.limit
//   console.log(timer.toString())
//   console.log(target)
//   return(timer.toString() === target);
// }

// function startTimerSession() {

//   const timer = new Timer();
//   timer.start();
//   timer.addEventListener('secondsUpdated', function (e) {
//     $('#timer').html(timer.getTimeValues().toString());
//     redirectToBreakNew(timer.getTimeValues())
//   });
// }
// global.startTimerSession = startTimerSession
