var ProjectView = {
    PlatformType: '',
    Quantity: 0,
    ProjectId:0,
    //MobileSpaceId:0,
    PlatformSchedulers: [],
    StoryType: 0,
}
async function Process(id) {
        //var mobileSpaces = [];
        //$.ajax({
        //type: 'GET',
        //    url: "https://localhost:44305" + "/Json/GetMobileSpaces/"+id,
        //dataType: 'json',
        //    success: function (data) {
        //        mobileSpaces = data;
        //}
        //});
   
     var mobilespaceshtml = "";
    const inputOptions = new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          'Post': 'Post',
          'Stories': 'Stories'
        })
      }, 1000)
    })
        await Swal.fire({
            title: 'Select Post Type',
            input: 'radio',
            inputOptions: inputOptions,
            showCancelButton: true,
            cancelButtonColor: '#d33',
            inputValidator: (value) => {
                if (!value) {
                    return 'You need to choose Type!'
                } else {
                    ProjectView.PlatformType = value;
                }
            }
        }).then((result) => {
            ProjectView.ProjectId = id;
            if (result.value == "Stories") {
                 storyswal();
            }
            if (result.value == "Post") {
                 Rangerswal();
            }  
        })

}
async function storyswal() {
    var selectstory = "";
    if (ProjectView.PlatformType == "Stories") {
        var selectstory = "<select required class='form-control show-tick' id='StoryType'><option value='0' selected>Story Per Day</option><option value='1'>Story Per Week</option><option value='2'>Story Per Month</option></select>"
    }
    await Swal.fire({
        title: 'Platforms',
        html: selectstory,
        allowOutsideClick: false,
        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then(() => {
        if (ProjectView.PlatformType == "Stories") {
            ProjectView.StoryType = $('#StoryType').val();
        }
    })
    Rangerswal();
}
async function Rangerswal() {


    await Swal.fire({
        title: 'Select quantity',
        icon: 'question',
        input: 'range',
        allowOutsideClick: false,
        inputAttributes: {
            min: 1,
            max: 50,
            step: 1
        },
        inputValue: 1
    }).then((result) => {

        ProjectView.Quantity = result.value;

    })
    var schedulerhtml = "";
    for (var x = 0; x < ProjectView.Quantity; x++) {
        schedulerhtml += "<div class='input-group'><div class='input-group-prepend'><span class='input-group-text'><i class='zmdi zmdi-time'></i></span></div><input type='text' class='form-control timepicker' placeholder='Please choose a time...'></div></br>";
    }

    await Swal.fire({
        title: 'Select time',
        html: schedulerhtml,
        onOpen: function () {
            $('.timepicker').each(function () {
                $(this).bootstrapMaterialDatePicker({
                    format: 'HH:mm',
                    clearButton: true,
                    date: false
                });
            });
        }
    }).then((accept) => {
        var inputElements = document.getElementsByClassName('timepicker');
        for (var i = 0; inputElements[i]; ++i) {
            ProjectView.PlatformSchedulers.push(inputElements[i].value);
        }
    }).then((result) => {
        $.ajax({ // ajax call starts
            url: "/Json/ProjectTaskCreate",
            type: 'post',
            data: ProjectView,
            success: function (data) {
                ShowResult(data);
            }

        });
    });
}
function DeletePlatformTask(id) {
    $.ajax({
        type: 'GET',
        url: "/Json/DeletePlatformTask/"+id,
        dataType: 'json',
        success: function (data) {
            ShowResult(data);
        }
    });
}
function ShowResult(data) {
    if (data == true) {
        Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'Added Successfully.',
            showConfirmButton: false,
            timer: 1500
        })
        location.reload(true);
    } if (data == false) {
        Swal.fire(
            'Error',
            'Error while adding data.',
            'error'
        );
    } if (data == null) {
        Swal.fire(
            'Not Found',
            'Data not found.',
            'warning'
        );
    }
}