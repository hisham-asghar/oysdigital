
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
    var today = new Date().toString("hh:mm tt");
    var schedulerhtml = "";
    for (var x = 0; x < ProjectView.Quantity; x++) {
        schedulerhtml += "<div class='row clearfix'><div class='col-sm-6'><div class='input-group'><div class='input-group-prepend'><span class='input-group-text'><i class='zmdi zmdi-time'></i></span></div><input type='text' value='" + today + "' class='form-control timepicker' id='" + x + "timer' placeholder='Please choose a time...'></div></div><div class='col-sm-6'><select class='form-control show-tick' id='" + x + "selecttime' onchange='Settime(" + x + ")'><option value=''>-- Time --</option><option value='10:00:00 AM'>Morning 10:00 am</option><option value='12:00:00 AM'>Afternoon 12:00 am</option><option value='3:00:00 PM'>Afternoon 3:00 pm</option><option value='5:00:00 PM'>Evening 5:00 pm</option><option value='7:00:00 PM'>Evening 7:00 m</option></select></div></div><br />";
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
        $.ajax({ // ajax call starts
            url: "/Json/ProjectTaskCreate",
            type: 'post',
            data: ProjectView,
            success: function (data) {
                if (data != null) {
                    var schedulingtime = "";
                    for (var i = 0; i < ProjectView.PlatformSchedulers.length; ++i) {
                        var time = new Date(data.projectTaskScheduling[i].time).toString("hh:mm tt");
                        schedulingtime += "<span class='btn btn-primary'>" + time + "</span>";
                    }
                    var projecttask = "<tr id = " + data.id + "><td>" + data.taskType + "-" + data.frequencyType + "</td><td>" + schedulingtime + "</td><td><a role='button' onclick=DeletePlatformTask(" + data.id + ") class='btn btn-sm btn-danger btn-round text-white'><i class='zmdi zmdi-delete'></i></a></td></tr>";
                    $('#myTask').prepend(projecttask);
                    ShowResult(data);
                    ProjectView = {
                        PlatformType: '',
                        Quantity: 0,
                        ProjectId: 0,
                        PlatformSchedulers: [],
                        StoryType: 0,
                    }
                }
            }

        });
    });
}
function Settime(id) {

    var data = $("#" + id + "selecttime").val();
    if (data != "") {
        $("#" + id + "timer").val(data);
    } else {
        var today = new Date().toString("hh:mm tt");
        $("#" + id + "timer").val(today);
    }
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
            url: "/Json/AllPlatforms",
            dataType: 'json',
            success: function (data) {
                platforms = data;
            }
        });
    
        var options = "";

        for (var i = 0; i < platforms.length; i++) {
            options += "<option value='" + platforms[i].id + "' selected>" + platforms[i].name + "</option>"
        }
        var selectplatform = "<div class='form-group'><input id='link' class='form-control' type='url' placeholder='https://example.com' pattern='https://.*' size='30' required/></div><div class='form-group'><select required class='form-control show-tick' id='platform'>" + options + "</select></div>";
    
    await Swal.fire({
        title: 'Platforms',
        html: selectplatform,
        allowOutsideClick: false,
        showCancelButton: true,
        cancelButtonColor: '#d33'
    }).then((result) => {
        if (result.isConfirmed) {

            projectplatform.PlatformId = $('#platform').val();
            projectplatform.Link = $('#link').val();
            const regex = new RegExp("^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$");
            if (projectplatform.Link == "") {
                Swal.fire(
                    'Error',
                    'Url field is required',
                    'error'
                ).then(() => {
                    CreatePlatform(id);
                });
                
            } else {
                    $.ajax({ // ajax call starts
                        url: "/Json/PlatformCreate",
                        type: 'post',
                        data: projectplatform,
                        success: function (data) {
                            if (data != null) {

                                var platf = `<span id="${data.id}" class='btn btn-primary btn-lg'><a href='${data.link}' target='_blank' class='text-white-50 btnspan'><i class='${data.platformIcon} fontXLarge'> ${data.platformName}</i></a><i class='ti-close text-danger font-bolde fontLarge' onclick="DeletePaltforms(${data.id},'${data.platformName}' )"></i></span>`;
                                $('#myPlat').append(platf);
                                Swal.fire(
                                    'Added',
                                    'Your Platform has been Added.',
                                    'success'
                                )
                            }
                        }

                    });
            }
        }
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
        showCancelButton: true,
        cancelButtonColor: '#d33',
        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then((result) => {
        if (result.isConfirmed) {
            projectNotes.AccessLevelTypeId = $('#AccessLevelTypeId').val();
            projectNotes.LabelTypeId = $('#LabelTypeId').val();
            projectNotes.Message = $('#Message').val();
            if (projectNotes.Message == "") {
                Swal.fire(
                    'Error!',
                    'Message Field is Required.',
                    'error'
                ).then(() => {
                    CreateNotes(id);
                })
                
               // return false;
            } else {
                $.ajax({ // ajax call starts
                    url: "/Json/CreateNotes",
                    type: 'post',
                    data: projectNotes,
                    success: function (data) {
                        if (data != null) {
                            var date = new Date(data.onCreated).toString("MMM dd,yy");
                            var time = new Date(data.onCreated).toString("hh:ss tt");
                            var notes = "<div class='row' id='" + data.id + "' label='" + data.labelTypeId + "'><div class='col-md-9 text-dark'>" + data.message + "</div><div class='col-md-2'><ul class='social-links list-unstyled'><li><span class='text-black-50'>" + date + "</span></li><li><span class='text-muted'>" + time + "</span></li><li><div class='press'><span class='badge text-white' style='background-color:" + data.labelColor + "'>" + data.labelName + "</span></div></li></ul></div><div class='col-md-1'><a role='button' onclick='DeleteNotes(" + data.id + ")' class='btn btn-sm btn-danger btn-round text-white'><i class='zmdi zmdi-delete'></a></li></div></div>";
                            $('#myNotes').prepend(notes);
                            // $('#myNotes').html(notes + $('#myNotes').html());
                            Swal.fire(
                                'Added',
                                'Your Note has been Added.',
                                'success'
                            )
                        }
                    }

                });
            }
        }
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
        showCancelButton: true,
        cancelButtonColor: '#d33',
        inputValidator: (value) => {
            if (!value) {
                return 'You need to choose something!'
            }
        }
    }).then((result) => {
        if (result.isConfirmed) {
            projectAlertMessages.LabelTypeId = $('#LabelTypeId').val();
            projectAlertMessages.Message = $('#Message').val();
            if (projectAlertMessages.Message == "") {
                Swal.fire(
                    'Error!',
                    'Message Field is Required.',
                    'error'
                ).then(() => {
                    CreateAlertMessages(id);
                })

                // return false;
            } else {
                $.ajax({ // ajax call starts
                    url: "/Json/CreateAlertMessages",
                    type: 'post',
                    data: projectAlertMessages,
                    success: function (data) {
                        var date = new Date(data.onCreated).toString("MMM dd,yy");
                        var time = new Date(data.onCreated).toString("hh:ss tt");
                        if (data != null) {
                            var alertcolor = "orange";
                            var alerttext = "NotDone";
                            if (data.alertTypeId == 1) {
                                alertcolor = "seagreen";
                                alerttext = "Done";
                            } if (data.alertTypeId == 2) {
                                alertcolor = "red";
                                alerttext = "Issue";
                            }


                            var alerts = `<div class="row" id="${data.id}" label="${data.labelTypeId}" alertlabel="${data.alertTypeId}">
                                    <div class="col-md-8 text-dark">
                                        ${data.message}
                                    </div>
                                    <div class="col-md-2">
                                        <ul class="social-links list-unstyled">
                                            <li><span class="text-black-50">${date}</span></li>
                                            <li><span class="text-muted">${time}</span></li>
                                            <li><div class="press"><span class="badge text-white" style="background-color:${data.labelColor}">${data.labelName}</span></div></li>
                                            <li><div id="alertdiv${data.id}"><div class="press" id="alert${data.id}"><span class="badge text-white" style="background-color:${alertcolor}">${alerttext}</span></div></div></li>
                                        </ul>
                                    </div>
                                    <div class="col-md-2">
                                        <a role="button" onclick="DeleteAlertMessages(${data.id})" class="btn btn-sm btn-danger btn-round text-white"><i class="zmdi zmdi-delete"></i></a>
                                        <a role="button" onclick="UpdateAlertMessages(${data.id},1)" class="btn btn-sm btn-success btn-round text-white" title="Mark as done"><i class="zmdi zmdi-check"></i></a>
                                        <a role="button" onclick="UpdateAlertMessages(${data.id},2)" class="btn btn-sm btn-danger btn-round text-white" title="Mark as Issue">Issue</a>
                                    </div>
                                </div>`;
                            $('#myAlertMessages').prepend(alerts);
                            Swal.fire(
                                'Added',
                                'Your Alert Messages has been Added.',
                                'success'
                            )
                        }
                    }

                });
            }
        }
    });
}

function DeleteMember(id,name,memberType) {
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
                    Show(memberType);
                }
            });

        }
    })

}
function Hide(memberType) {
    if (memberType == "Designer") {
        $("#btndesigner").hide();
    }
    if (memberType == "Scheduler") {
        $("#btnscheduler").hide();
    }
}
function Show(memberType) {
    if (memberType == "Designer") {
        $("#btndesigner").show();
    }
    if (memberType == "Scheduler") {
        $("#btnscheduler").show();
    }
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
                    var members = `<tr id="${data.id}"><td><div style="width:50px;height:auto" class="rounded-circle"><img src="/images/profile_av.jpg" class="img-fluid" alt=""></div></td><td><ul class="social-links list-unstyled"><li><span>${data.memberName}</span></li><li><span class="text-muted">${data.memberType}</span></li></ul></td><td><a onclick="DeleteMember(${data.id},'${data.memberName}','${data.memberType}')" role="button" class="btn btn-sm btn-danger btn-round text-white"><i class="zmdi zmdi-delete"></i></a></td></tr>`;
                    $('#myMembers').append(members);
                    Swal.fire(
                        'Added',
                        'Your Members has been Added.',
                        'success'
                    )
                    Hide(memberType);
                }
            }

        });
    });
}
function removeElement(elementId) {
    $("#" + elementId).remove();
    // Removes an element from the document
    //var element = document.getElementById(elementId);
   // element.parentNode.removeChild(element);
}
function Notesfilter() {
    var noteType = $("#Notes").val();
    if (noteType == 0) {
        $("#myNotes div[label]").show();
    } else {
        $("#myNotes div[label]").hide();
        $("#myNotes div[label=" + noteType + "]").show();
    }
}
function Alertfilter() {
    var alertType = $("#Alerts").val();
    if (alertType == "") {
        $("#myAlertMessages div[label]").show();
    } else {
        $("#myAlertMessages div[label]").hide();
        $("#myAlertMessages div[label=" + alertType + "]").show();
    }
}
function AlertTypefilter() {
    var alertType = $("#AlertType").val();
    if (alertType == "") {
        $("#myAlertMessages div[alertlabel]").show();
    } else {
        $("#myAlertMessages div[alertlabel]").hide();
        $("#myAlertMessages div[alertlabel=" + alertType + "]").show();
    }
}
function UpdateAlertMessages(id,status) {
    Swal.fire({
        title: 'Are you sure to do this ?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: status==1?'Mark as Done':'Mark as Issue'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'Post',
                url: "/Json/UpdateAlertStatus",
                dataType: 'json',
                data: {id:id,status:status},
                success: function (data) {
                    var color = "";
                    var text = "";
                    if (data.alertTypeId == 1)
                        color = "seagreen";
                    else
                        color = "red";
                    if (data.alertTypeId == 1)
                        text = "Done";
                    else
                        text = "Issue";
                    var status = `<span class="press" id="alert${data.alertTypeId}"><span class="badge text-white" style="background-color:${color}">${text}</span></span>`;
                    var alert = "#alert" + data.id;
                    var alertdiv = "#alertdiv" + data.id;
                    $(alert).remove();
                    $(alertdiv).append(status);
                    $("#" + id).attr("alertlabel", data.alertTypeId);
                    if (data == false) {
                        Swal.fire(
                            'Issue',
                            'Data not found.',
                            'danger'
                        );
                    } else {
                        Swal.fire(
                            'Done',
                            'Updated Successfully.',
                            'success'
                        );
                    }
                }
            });

        }
    })

}