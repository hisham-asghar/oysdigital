var host = ""
$(document).ready(function () {
    $(".btn-mark-design-done").each(function () {
        $(this).click(function () {
            var parentRow = $(this).closest("tr");
            var title = parentRow.attr("title");
            var projectId = parentRow.attr("project-id");
            var date = parentRow.attr("date");
            MarkProjectDesignDone(title, projectId, date);
        });
    });
    $(".btn-mark-schedule-done-popup").each(function () {
        $(this).click(function () {
            var parentRow = $(this).closest("tr");
            //var title = parentRow.attr("title");
            var projectId = parentRow.attr("project-id");
            var date = parentRow.attr("date");
            var list = [];
            parentRow.find("[platform-ids]").each(function () {
                var ids = $(this).attr("platform-ids");
                var name = $(this).attr("platform-name");

                if ($(this).hasClass("badge-with-extra")) {
                    name += $(this).find(".badge").text();
                }
                var status = $(this).hasClass("badge-success");
                console.log(ids + " => " + name);
                var obj = { "ids": ids, "name": name, "status": status };
                list.push(obj);
            });
            var platformHtml = "";
            for (var i = 0; i < list.length; i++) {
                platformHtml += "<div class='form-group'><input type='checkbox'  value='" + list[i].ids + "' " + (list[i].status ? "checked=''" : "") + " name='PlatformCheckbox'/>  " + list[i].name + "</div>"
            }

            $('#myPlatforms').html(platformHtml);
            $('#myPlatforms').attr("project-id", projectId);
            $('#myPlatforms').attr("date", date);
            $("#smallModal").modal('show')
        });
    });
});
async function MarkProjectDesignDone(title, projectId, date) {
    Swal.fire({
        title: 'Are you sure you want to mark ' + title + ' project design as done ?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: 'POST',
                url: "/Json/ProjectDesignDone/" + projectId + "?date=" + date,
                dataType: 'json',
                success: function (data) {
                    location.reload();
                    if (data == true) {
                        $("tr[project-id=" + projectId + "]").addClass("bg-success");
                    }
                }
            });

        }
    })
}
function SwalPlatformsOpen() {

    var projectId = $('#myPlatforms').attr("project-id");
    var date = $('#myPlatforms').attr("date");
    projectId = parseInt(projectId);
    var TaskPlatforms = new Array();
    var inputElements = document.getElementsByName('PlatformCheckbox');
    for (var i = 0; inputElements[i]; ++i) {
        if (inputElements[i].checked) {
            TaskPlatforms.push(inputElements[i].value);
        }
    }
    var plaformIds = TaskPlatforms.join(",");
    $.ajax({
        url: host + "/Json/PlatformScheduleDone",
        type: 'POST',
        data: { platformIds: plaformIds, projectId: projectId, date: date },
        traditional: true,
        dataType: 'json',
        success: function (data) {
            location.reload();
        }
    });
}

function ShowModalPopUpForScheduleDone() {
    var platforms = [];
    var platformHtml = "";
    $('#' + id).each(function () {
        var component = $(this);
        platforms = component.data('options');
        console.log(platforms);
    });
    for (var i = 0; i < platforms.length; i++) {
        platformHtml += "<div class='form-group'><input type='checkbox'  value='" + projectPlatformList[i] + "' name='PlatformCheckbox'/>  " + platforms[i].PlatformName + "</div>"
    }
    $('#myPlatforms').html(platformHtml);
    $('#projectId').val(projectId);
}
function GenerateNextTask() {
    $.ajax({
        url: host + "/Json/GenerateTomorrowTask",
            type: 'GET',
            dataType: 'json',
            success: function (d)
            {
                if (d != null) {
                    Swal.fire({
                        position: 'top-end',
                        icon: 'success',
                        title: 'Your next day tasks has been generated',
                        showConfirmButton: false,
                        timer: 1500
                    })
                    location.reload(true);
                }

            }
        });
}
function DeleteMember(id) {
    $.ajax({
        url: host + "/Json/DeleteMember/"+id,
        type: 'GET',
        dataType: 'json',
        success: function (d) {
            if (d ==true) {
                Swal.fire({
                    position: 'top-end',
                    icon: 'success',
                    title: 'Member Deleted Succefully',
                    showConfirmButton: false,
                    timer: 1500
                })
                location.reload(true);
            }

        }
    });
}
    function ReportTask(id) {
        $.ajax({
            url: host + "/Json/ReportTask/"+id ,
                    type: 'GET',
                    dataType: 'json',
                    success: function (data)
                    {
                        if (data == true) {
                            Swal.fire({
                                position: 'top-end',
                                icon: 'success',
                                title: 'Task has been Reported',
                                showConfirmButton: false,
                                timer: 1500
                            })
                        } if (data == false) {
                            Swal.fire(
                                'Not Reported',
                                'Your task has not been Reported.',
                                'error'
                            );
                        } if(data==null){
                            Swal.fire(
                                'Not Found',
                                'Task not found.',
                                'warning'
                            );
                        }
                    }
                });
}

    function GeneratePlatforms(id,projectId,projectPlatformList) {
        var platforms = [];
        var platformHtml = "";
        $('#'+id).each(function () {
            var component = $(this);
            platforms=component.data('options');
            console.log(platforms);
        });
        for (var i = 0; i < platforms.length; i++) {
            platformHtml += "<div class='form-group'><input type='checkbox'  value='" + projectPlatformList[i] + "' name='PlatformCheckbox'/>  " + platforms[i].PlatformName + "</div>"
         }
        $('#myPlatforms').html(platformHtml);
        $('#projectId').val(projectId);
        }
function SwalPlatformsOpenOld() {
    var projectId = $('#projectId').val();
        var TaskPlatforms = new Array();
        var inputElements = document.getElementsByName('PlatformCheckbox');
        for (var i = 0; inputElements[i]; ++i) {
            if (inputElements[i].checked) {
                TaskPlatforms.push(inputElements[i].value );
            }
        }
         $.ajax({
             url: host + "/Json/MultiPlatform" ,
                     type: 'POST',
             data: { id: TaskPlatforms, projectId: projectId},
                     traditional: true,
                     dataType: 'json',
                    success: function (data)
                    {
                        if (data == true) {
                            Swal.fire({
                                position: 'top-end',
                                icon: 'success',
                                title: 'Platform has been Updated',
                                showConfirmButton: false,
                                timer: 1500
                            });
                            location.reload(true);
                        } if (data == false) {
                            Swal.fire(
                                'Not Updated',
                                'Your file has been Updated.',
                                'error'
                            );
                        } if(data==null){
                            Swal.fire(
                                'Not Found',
                                'Platform not found.',
                                'warning'
                            );
                        }
                    }
                });
    }
function SwalOpen(projectPlatformList) {
    
        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },

            buttonsStyling: false
        })

        swalWithBootstrapButtons.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Mark Done',
            cancelButtonText: 'Mark Not Done',
            reverseButtons: true
        }).then((result) => {
            if (result.value) {
                SinglePlatform(projectPlatformList, result.value);
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                SinglePlatform(projectPlatformList, result.value);
            }
        })
    }
function SinglePlatform(projectPlatformList, status) {
                 $.ajax({
                     url: host + "/Json/SinglePlatform" ,
                    type: 'POST',
                     data: ({ projectPlatformList: projectPlatformList, status:status }),
                    dataType: 'json',
                    success: function (data)
                    {
                        if (data == true) {
                            Swal.fire({
                                position: 'top-end',
                                icon: 'success',
                                title: 'Platform has been Updated',
                                showConfirmButton: false,
                                timer: 1500
                            });
                            location.reload(true);
                        } if (data == false) {
                            Swal.fire(
                                'Not Updated',
                                'Your file has been Updated.',
                                'error'
                            );
                        } if(data==null){
                            Swal.fire(
                                'Not Found',
                                'Platform not found.',
                                'warning'
                            );
                        }
                    }
                });

            }
    function GenerateTask() {
        $.ajax({
            url: host +"/Json/GenerateTask",
            type: 'GET',
            dataType: 'json',
            success: function (d)
            {
                if (d != null) {
                    Swal.fire({
                        position: 'top-end',
                        icon: 'success',
                        title: 'Your tasks has been generated',
                        showConfirmButton: false,
                        timer: 1500
                    })
                    location.reload(true);
                } else {
                    Swal.fire({
                        position: 'top-end',
                        icon: 'warning',
                        title: 'Tasks already generated',
                        showConfirmButton: false,
                        timer: 1500
                    })
                }

            }
        });
}
function selectAll() {
    var inputs = document.getElementsByTagName("input");
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].type == "checkbox") {
            inputs[i].checked = true;
            // This way it won't flip flop them and will set them all to the same value which is passed into the function
        }
    }  
}
function FilterTable(startDate,endDate,userId) {
    $.ajax({
        url: host + "/Json/DashBoardFilter",
        type: 'GET',
        data: { startDate: startDate, endDate: endDate, userId: userId },
        dataType: 'json',
        success: function (d) {
            if (d == true) {
                Swal.fire({
                    position: 'top-end',
                    icon: 'success',
                    title: 'Member Deleted Succefully',
                    showConfirmButton: false,
                    timer: 1500
                })
                location.reload(true);
            }

        }
    });
}