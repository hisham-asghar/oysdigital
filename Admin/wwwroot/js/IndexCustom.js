var host =""
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
function SwalPlatformsOpen() {
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