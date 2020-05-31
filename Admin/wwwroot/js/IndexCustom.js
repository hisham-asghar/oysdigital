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
    function GeneratePlatforms(id) {
        var platforms = [];
        var platformHtml = "";
        $('#'+id).each(function () {
            var component = $(this);
            platforms=component.data('options');
            console.log(platforms);
        });
        for (var i = 0; i < platforms.length; i++) {
            platformHtml += "<div class='form-group'><input type='checkbox'  value='"  + platforms[i].Id + "' name='PlatformCheckbox'/>  " + platforms[i].PlatformName + "</div>"
        }
        $('#myPlatforms').html(platformHtml);
        }
    function SwalPlatformsOpen() {
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
                     data: { id: TaskPlatforms },
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
        function SwalOpen(id) {
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
                SinglePlatform(id, result.value);
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                SinglePlatform(id, result.value);
            }
        })
    }
    function SinglePlatform(id, status) {
                 $.ajax({
                     url: host + "/Json/SinglePlatform" ,
                    type: 'POST',
                    data: ({ id: id, status:status }),
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
    var inputElements = document.getElementsByName('PlatformCheckbox');
    for (var i = 0; inputElements[i]; ++i) {
        inputElements[i].checked = source.checked;
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