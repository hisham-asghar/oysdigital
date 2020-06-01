var ProjectView = {
    PlatformType: '',
    Quantity: 0,
    ProjectId:0,
    PlatformSchedulers: [],
    StoryType: 0,
}
async function Process(id) {
        
   
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
        allowOutsideClick: false,
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
                if (data != null)
                {
                    var schedulingtime = "";
                    for (var i = 0; i < data.projectTaskScheduling.length; i++) {
                        schedulingtime += "<span class='btn btn-primary'>" + data.projectTaskScheduling[0].time+ "</span>";
                    }
                    var projecttask = "<tr id = '"+data.id+"'><td></td><td>"+ schedulingtime +"</td><td><a role='button' onclick='DeletePlatformTask('"+data.id+")' class='btn btn-sm btn-danger btn-round text-white'><i class='zmdi zmdi-delete'></i></a></td></tr>";
                    $('#myTask').append(projecttask);
                    ShowResult(data);
                }
            }

        });
    });
}
function DeletePlatformTask(id) {
    Swal.fire({
        title: 'Are you sure to delete this task?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'GET',
                url: "/Json/DeletePlatformTask/" + id,
                dataType: 'json',
                success: function (data) {
                    DeleteResult(data, id);
                }
            });
        }
    });
}
function DeleteResult(data,id) {
    if (data == true) {
        removeElement(id);
        Swal.fire(
            'Deleted!',
            'Your file has been deleted.',
            'success'
        )
    } else {
        Swal.fire(
            'Not Deleted!',
            'Something went wrong while deleting.',
            'error'
        )
    }
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
function DeletePaltforms(id , name) {
    Swal.fire({
        title: 'Are you sure to delete ?'+name,
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'GET',
                url: "/Json/DeletePlatform/" + id,
                dataType: 'json',
                success: function (data) {
                    DeleteResult(data,id);
                }
            });
           
        }
    })
}
async function CreatePlatform(id) {
    projectplatform = {
        PlatformId:0,
        ProjectId:id,
        Link:''
    }
    var platforms = [];
    await $.ajax({
        type: 'GET',
            url:"/Json/AllPlatforms",
        dataType: 'json',
            success: function (data) {
               platforms = data;
        }
        });
    
    var options = "";
   
    for (var i = 0; i < platforms.length; i++)
    {
        options += "<option value='" + platforms[i].id + "' selected>" + platforms[i].name+"</option>"
    }
    var selectplatform = "<div class='form-group'><input id='link' class='form-control' placeholder='Platform Link' type='text'/></div><div class='form-group'><select required class='form-control show-tick' id='platform'>" + options + "</select></div>";
   
    await Swal.fire({
        title: 'Platforms',
        html: selectplatform,
        allowOutsideClick: false,
        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then(() => {
        projectplatform.PlatformId = $('#platform').val();
        projectplatform.Link = $('#link').val();
        $.ajax({ // ajax call starts
            url: "/Json/PlatformCreate",
            type: 'post',
            data: projectplatform,
            success: function (data) {
                if (data != null) {
                    var platf = "<span id='" + data.id + "'><a href='" + data.link + "' target='_blank' class='btn'><i class='" + data.platformIcon + "'></i></a> " + data.platformName + "  <span class='ti-close text-danger font-bold' onclick='DeletePaltforms(" + data.id + "," + data.platformName + ")'></span></span>";
                    $('#myPlat').append(platf);
                    Swal.fire(
                        'Added',
                        'Your Platform has been Added.',
                        'success'
                    )
                }
            }

        });
    })
}
function DeleteNotes(id) {
    Swal.fire({
        title: 'Are you sure to delete ?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'GET',
                url: "/Json/DeleteNotes/" + id,
                dataType: 'json',
                success: function (data) {
                    DeleteResult(data, id);
                }
            });

        }
    })
    
}
async function CreateNotes(id) {
    projectNotes = {
        AccessLevelTypeId: 0,
        ProjectId: id,
        LabelTypeId: 0,
        Message:''
    }
    var labelTypes = [];
    await $.ajax({
        type: 'GET',
        url: "/Json/AllLabels",
        dataType: 'json',
        success: function (data) {
            labelTypes = data;
        }
    });
    
    var options = "";
    var assesslevel = "<div class='form-group'><select required class='form-control show-tick' id='AccessLevelTypeId'><option value='0' selected> Admin</option><option value='1' selected> Manager</option><option value='2' selected> Member</option></select></div>"    
    for (var i = 0; i < labelTypes.length; i++) {
        options += "<option value='" + labelTypes[i].id + "' selected>" + labelTypes[i].name + "</option>"
    }
    var selectLabel = "<div class='form-group'><select required class='form-control show-tick' id='LabelTypeId'>" + options + "</select></div>" + assesslevel + "<div class='form-group'><textarea class='form-control' id='Message'></textarea></div>";
    
    await Swal.fire({
        title: 'Notes',
        html: selectLabel,
        allowOutsideClick: false,

        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then(() => {
        projectNotes.AccessLevelTypeId = $('#AccessLevelTypeId').val();
        projectNotes.LabelTypeId = $('#LabelTypeId').val();
        projectNotes.Message = $('#Message').val();
     
        $.ajax({ // ajax call starts
            url: "/Json/CreateNotes",
            type: 'post',
            data: projectNotes,
            success: function (data) {
                if (data != null) {
                    var notes = "<div class='row' id='"+data.id+"'><div class='col-md-10 text-dark'>"+data.message+"</div><div class='col-md-2'><ul class='social-links list-unstyled'><li><span>"+data.onCreated+"</span></li><li><span class='text-muted'>"+data.onCreated+"</span></li><li><div class='press'><span class='badge text-white' style='background-color:"+data.labelColor+"'>"+data.labelName+"</span></div></li><li><a role='button' onclick='DeleteNotes("+data.id+")' class='btn btn-sm btn-danger btn-round text-white'><i class='zmdi zmdi-delete'></i></a></li></ul></div></div>";
                    $('#myNotes').append(notes);
                    Swal.fire(
                        'Added',
                        'Your Note has been Added.',
                        'success'
                    )
                }
            }

        });
    });
}
function DeleteAlertMessages(id) {
    Swal.fire({
        title: 'Are you sure to delete ?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'GET',
                url: "/Json/DeleteAlertMessages/" + id,
                dataType: 'json',
                success: function (data) {
                    DeleteResult(data, id);
                }
            });

        }
    })

}
async function CreateAlertMessages(id) {
    projectAlertMessages = {
        ProjectId: id,
        LabelTypeId: 0,
        Message: ''
    }
    var labelTypes = [];
    await $.ajax({
        type: 'GET',
        url: "/Json/AllLabels",
        dataType: 'json',
        success: function (data) {
            labelTypes = data;
        }
    });

    var options = "";
    for (var i = 0; i < labelTypes.length; i++) {
        options += "<option value='" + labelTypes[i].id + "' selected>" + labelTypes[i].name + "</option>"
    }
    var selectLabel = "<div class='form-group'><select required class='form-control show-tick' id='LabelTypeId'>" + options + "</select></div><div class='form-group'><textarea class='form-control' id='Message'></textarea></div>";

    await Swal.fire({
        title: 'Alert Messages',
        html: selectLabel,
        allowOutsideClick: false,

        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then(() => {
        projectAlertMessages.LabelTypeId = $('#LabelTypeId').val();
        projectAlertMessages.Message = $('#Message').val();

        $.ajax({ // ajax call starts
            url: "/Json/CreateAlertMessages",
            type: 'post',
            data: projectAlertMessages,
            success: function (data) {
                if (data != null) {
                    var notes = "<div class='row' id='" + data.id + "'><div class='col-md-10 text-dark'>" + data.message + "</div><div class='col-md-2'><ul class='social-links list-unstyled'><li><span>" + data.onCreated + "</span></li><li><span class='text-muted'>" + data.onCreated + "</span></li><li><div class='press'><span class='badge text-white' style='background-color:" + data.labelColor + "'>" + data.labelName + "</span></div></li><li><a role='button' onclick='DeleteNotes(" + data.id + ")' class='btn btn-sm btn-danger btn-round text-white'><i class='zmdi zmdi-delete'></i></a></li></ul></div></div>";
                    $('#myAlertMessages').append(notes);
                    Swal.fire(
                        'Added',
                        'Your Alert Messages has been Added.',
                        'success'
                    )
                }
            }

        });
    });
}

function DeleteMember(id,name) {
    Swal.fire({
        title: 'Are you sure to delete '+name+' ?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'GET',
                url: "/Json/DeleteMember/" + id,
                dataType: 'json',
                success: function (data) {
                    DeleteResult(data, id);
                }
            });

        }
    })

}
async function CreateMember(id,memberType) {
    projectMembers = {
        ProjectId: id,
        AspNetUserId: '',
        MemberType: memberType
    }
    var users = [];
    await $.ajax({
        type: 'GET',
        url: "/Json/AllUsers/" + memberType,
        dataType: 'json',
        success: function (data) {
            users = data;
        }
    });
   
    var options = "";
    for (var i = 0; i < users.length; i++) {
        options += "<option value='" + users[i].id + "' selected>" + users[i].name + "</option>"
    }
    var selectLabel = "<div class='form-group'><select required class='form-control show-tick' id='Id'>" + options + "</select></div>";

    await Swal.fire({
        title: 'ProjectMembers',
        html: selectLabel,
        allowOutsideClick: false,

        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then(() => {
        projectMembers.AspNetUserId = $('#Id').val();
        $.ajax({ // ajax call starts
            url: "/Json/CreateMember",
            type: 'post',
            data: projectMembers,
            success: function (data) {
                if (data != null) {
                    var members = "<tr id='"+data.id+"'><td><div style='width:50px;height:auto' class='rounded-circle'><img src='/images/profile_av.jpg' class='img-fluid' alt=''></div></td><td><ul class='social-links list-unstyled'><li><span>"+data.memberName+"</span></li><li><span class='text-muted'>"+data.memberType+"</span></li></ul></td><td><a onclick='DeleteMember('"+data.id+",'"+data.memberName+"')' role='button' class='btn btn-sm btn-danger btn-round text-white'><i class='zmdi zmdi-delete'></i></a></td></tr>";
                    $('#myMembers').append(members);
                    Swal.fire(
                        'Added',
                        'Your Members has been Added.',
                        'success'
                    )
                }
            }

        });
    });
}
function removeElement(elementId) {
    // Removes an element from the document
    var element = document.getElementById(elementId);
    element.parentNode.removeChild(element);
}
