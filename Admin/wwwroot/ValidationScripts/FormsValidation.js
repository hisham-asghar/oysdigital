$(function () {
    $(document).ready(function () {
        // Initialize form validation on the registration form.
        // It has the name attribute "registration"
        $("form[name='customer']").validate({
            rules: {
                Name: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z'.\\s]{1,40}$" },
                Email: { required: true, regex: "^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}$" },
                Address: { required: true, minlength: 5, maxlength: 45 },
                PhoneNumber: { required: true, minlength: 10, maxlength: 30, regex: "^[0-9'.\\s]+[0-9]{1,40}$" }
            },
            // Specify validation error messages
            messages: {
                Name: {
                    required: "Please enter your Customer Name",
                    minlength: "Customer name must be at least 3 characters long",
                    maxlength: "Customer name must be at least 3 characters long",
                    regex: "Only Character are allowed"
                },
                Email: {
                    required: "Please enter your Email",
                    regex: "Email should be in this formate (abs@xyz.com)"
                },
                Address: {
                    required: "Please enter your Adderss",
                    minlength: "Adderss must be at least 5 characters long",
                    maxlength: "Adderss must be at least 45 characters long",
                },
                PhoneNumber: {
                    required: "Please enter your PhoneNumber",
                    minlength: "PhoneNumber must be at least 10 characters long",
                    maxlength: "PhoneNumber name must be at least 30 characters long",
                    regex: "Only numbers are allowed"
                },
            },
            // Make sure the form is submitted to the destination defined
            // in the "action" attribute of the form when valid
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='mobile']").validate({
            rules: {
                Name: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{1,25}$" }
            },
            messages: {
                Name: {
                    required: "Please enter your Mobile Name",
                    minlength: "Mobile name must be at least 3 characters long",
                    maxlength: "Mobile name must be at least 25 characters long",
                    regex: "Only Character and numarical values are allowed"
                }
            },
            // Make sure the form is submitted to the destination defined
            // in the "action" attribute of the form when valid
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='mobilespaces']").validate({
            rules: {
                Name: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{1,25}$" },
                MobileId: "required"
            },
            messages: {
                Name: {
                    required: "Please enter your Mobile Space Name",
                    minlength: "Mobile Space name must be at least 3 characters long",
                    maxlength: "Mobile Space name must be at least 25 characters long",
                    regex: "Only Character and numarical values are allowed"
                },
                MobileId: "Please select mobile"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='platform']").validate({
            rules: {
                Name: "required"
            },
            messages: {
                Name: "Please select a Platform"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='projectmessages']").validate({
            rules: {
                Message: { required: true, minlength: 10, maxlength: 150 },
                LabelTypeId: "required"
            },
            messages: {
                Message: {
                    required: "Please enter your Message",
                    minlength: "Message must be at least 10 characters long",
                    maxlength: "Message must be at least 150 characters long"
                },
                LabelTypeId: "Please select message type"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='project']").validate({
            rules: {
                Name: { required: true, minlength: 3, maxlength: 150, regex: "^[a-zA-Z0-9'.\\s]{3,25}$" }
            },
            messages: {
                Name: {
                    required: "Please enter your project name",
                    minlength: "Project name must be at least 3 characters long",
                    maxlength: "Project name be at least 25 characters long",
                    regex: "Only Character and numarical values are allowed"
                }
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='projectmember']").validate({
            rules: {
                ProjectMemberTypesId: "required"
            },
            messages: {
                ProjectMemberTypesId: "Please select member type"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='projectmembertype']").validate({
            rules: {
                Name: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{3,25}$" }
            },
            messages: {
                Name: {
                    required: "Please enter your Project Member Type Name",
                    minlength: "Project Member Type Name must be at least 3 characters long",
                    maxlength: "Project Member Type Name be at least 25 characters long",
                    regex: "Only character and numarical values are allowed"
                }
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='projectnotes']").validate({
            rules: {
                Message: { required: true, minlength: 10, maxlength: 150 },
                NoteTypeId: "required"
            },
            messages: {
                Message: {
                    required: "Please enter your Message",
                    minlength: "Message must be at least 10 characters long",
                    maxlength: "Message must be at least 150 characters long"
                },
                NoteTypeId: "Please select note type"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        $("form[name='projectplatform']").validate({
            rules: {
                Id: "required",
                ProjectId: "required",
                PlatformId: "required",
                PlatformLink: "required",
                MobileSpaceId: "required",
                PostType: "required",
                PostCount: { required: true, minlength: 1, maxlength: 150, regex: "^[0-9]{1,150}$" },
                PostSchedulingTime: "required",
                StoriesType: "required",
                StoriesCount: { required: true, minlength: 1, maxlength: 150, regex: "^[0-9]{1,150}$" },
                StoriesSchedulingTime: "required",
            },
            // Specify validation error messages
            messages: {
                Id: "Please select platform name",
                ProjectId: "Please select your Project",
                PlatformId: "Please select your Platform",
                PlatformLink: "Please enter your PlatformLink",
                MobileSpaceId: "Please select mobile space name",
                PostType: "Please select posts plan",
                PostsQuantity: {
                    required: "Please enter your post quantity",
                    minlength: "Post quantity must be at least 1 numeric long",
                    maxlength: "Post quantity must be at least 150 characters long",
                    regex: "Only numerical values are allowed"
                },
                PostSchedulingTime: "Please select post scheduling time",
                StoriesType: "Please select stories/status plan",
                StoriesQuantity: {
                    required: "Please enter your stories/status quantity",
                    minlength: "Stories quantity must be at least 1 numeric long",
                    maxlength: "Stories quantity must be at least 150 characters long",
                    regex: "Only numerical values are allowed"
                },
                StoriesSchedulingTime: "Please select stories/status scheduling time",
            },
            // Make sure the form is submitted to the destination defined
            // in the "action" attribute of the form when valid
            submitHandler: function (form) {
                form.submit();
            }
        });
    })    
});
