var poststoriestemplate = $('#post-stories-template > div').clone()[0];
$('#post-stories-template').remove();
// prepare poststorytemplate configuration
var swalpoststoriesConfig = {
  title: 'Click on platform',
  content: poststoriestemplate,
 button:false
}
$('body').on('click', '#btnpost', function() {
var postplatformtemplate = $('#postplatform-template > div').clone()[0];
$('#postplatform-template').remove();
/*var val = [];
        $(':checkbox:checked').each(function(i){
          val[i] = $(this).val();
        });
*/


var postplatformtemplateConfig = {
  title: 'Platform Scheduler',
  content: postplatformtemplate,
  button:false
};
swal(postplatformtemplateConfig);
});
//add post pltform scheduller
$('body').on('click', '#btnpostplatform', function() {
var platformschedulertemplate = $('#platformschedulertemplate > form').clone()[0];
$('#platformschedulertemplate').remove();
var swalPostPlatformSchedulerConfig = {
  title: 'Platform Scheduler',
  content: platformschedulertemplate,
  button:false
};
	swal(swalPostPlatformSchedulerConfig);
});


// stories pending
$('body').on('click', '#btnstories', function() {
	var forms = $('.myfrom').html();
	swal({
    title: 'edit form',
    content: forms,
    button: true
})

});
function plstformsubmit(){
	let itemsArray = []
localStorage.setItem('items', JSON.stringify(itemsArray));
//const data = JSON.parse(localStorage.getItem('items'))
}
function submitform(){
	
      //  var myForm = $("#contact-form");
       // if(myForm.valid()){

            var theData = {
                 quantity: $('#quantity').val(),
                 timer: $('#timer').val(),
            };

            $.ajax({ // ajax call starts
                url: "http://plantswap.com.au/wp-content/themes/flatads/tell_a_friend.php",
                type: 'post',
                data: theData,
                success: function(data)
                {
                    swal("Your request has been received!", "We will contact you for confirmation soon", "success");
                    document.getElementById('friend_name').value='',
                    document.getElementById('email').value='';

                }

            });
        
   
	
}







 

 

// prepare SweetAlert configuration



// handle clicks on the "Submit" button of the modal form
//$('body').on('click', '.swal-button--confirm', function() {
//  simulateAjaxRequest();
//});

// mock AJAX requests for this demo
var isFakeAjaxRequestSuccessfull = false;

function simulateAjaxRequest() {
  // "send" the fake AJAX request
  var fakeAjaxRequest = new Promise(function (resolve, reject) {
    setTimeout(function () {
      isFakeAjaxRequestSuccessfull ? resolve() : reject();
      isFakeAjaxRequestSuccessfull = !isFakeAjaxRequestSuccessfull;
      swal.stopLoading();
    }, 200);
  });
  
  // attach success and error handlers to the fake AJAX request
  fakeAjaxRequest.then(function () {
    // do this if the AJAX request is successfull:
    $('input.invalid').removeClass('invalid');
    $('.invalid-feedback').remove();
  }).catch(function () {
    // do this if the AJAX request fails:
    var errors = {
      username: 'Username is invalid',
      password: 'Password is invalid'
    };
    $.each(errors, function(key, value) {
      $('input[name="' + key + '"]').addClass('invalid').after('<div class="invalid-feedback">' + value + '</div>');
    });
  });
}
   
   
   
   
   
   
   
   
   
   
   