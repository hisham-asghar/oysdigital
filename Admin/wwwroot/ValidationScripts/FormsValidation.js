$(function () {
    // Initialize form validation on the registration form.
    // It has the name attribute "registration"
    $("form[name='Customer_form']").validate({
        rules: {
            CustomerName: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z'.\\s]{1,40}$" },
            Email: { required: true, regex: "^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}$" },
            Address: { required: true, minlength: 5, maxlength: 45 },
            PhoneNumber: { required: true, minlength: 10, maxlength: 30, regex: "^[0-9'.\\s]+[0-9]{1,40}$" }
        },
        // Specify validation error messages
        messages: {
            CustomerName: {
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
    $("form[name='Mobile_Form']").validate({
        rules: {
            MobileName: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{1,25}$" }
        },
        messages: {
            MobileName: {
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
    $("form[name='MobileSpaces_Form']").validate({
        rules: {
            SpaceName: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{1,25}$" },
            MobileId: "required"
        },
        messages: {
            SpaceName: {
                required: "Please enter your Mobile Space Name",
                minlength: "Mobile Space name must be at least 3 characters long",
                maxlength: "Mobile Space name must be at least 25 characters long",
                regex: "Only Character and numarical values are allowed"
            },
            MobileId:"Please select mobile"
        },
        submitHandler: function (form) {
            form.submit();
        }
    });
    $("form[name='Platform_Form']").validate({
        rules: {
            PlatformName: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{3,25}$" },
            file: "required"
        },
        messages: {
            SpaceName: {
                required: "Please enter your platform name",
                minlength: "Platform Space name must be at least 3 characters long",
                maxlength: "Platform Space name must be at least 25 characters long",
                regex: "Only Character and numarical values are allowed"
            },
            file: "Please select a file"
        },
        submitHandler: function (form) {
            form.submit();
        }
    });
    $("form[name='ProjectMessages_Form']").validate({
        rules: {
            Message: { required: true, minlength: 10, maxlength: 150 },
            ProjectMessageTypeId: "required"
        },
        messages: {
            Message: {
                required: "Please enter your Message",
                minlength: "Message must be at least 10 characters long",
                maxlength: "Message must be at least 150 characters long"
            },
            ProjectMessageTypeId: "Please select message type"
        },
        submitHandler: function (form) {
            form.submit();
        }
    });
    $("form[name='Project_Form']").validate({
        rules: {
            ProjectName: { required: true, minlength: 3, maxlength: 150, regex: "^[a-zA-Z0-9'.\\s]{3,25}$" }
        },
        messages: {
            ProjectName: {
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
    $("form[name='ProjectMember_Form']").validate({
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
    $("form[name='ProjectMemberType_Form']").validate({
        rules: {
            ProjectMemberTypeName: { required: true, minlength: 3, maxlength: 25, regex: "^[a-zA-Z0-9'.\\s]{3,25}$" }
        },
        messages: {
            ProjectMemberTypeName: {
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
    $("form[name='ProjectNotes_Form']").validate({
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
    $("form[name='ProjectPlatform_Form']").validate({
        rules: {
            PlatformId: "required",
            PlatformLink: "required",
            MobileSpacesId: "required",
            PostPerDay: "required",
            PostsQuantity: { required: true, minlength: 1, maxlength: 150, regex: "^[0-9]{1,150}$" },
            PostSchedulingTime:"required",
            StoriesPerDay: "required",
            StoriesQuantity: { required: true, minlength: 1, maxlength: 150, regex: "^[0-9]{1,150}$" },
            StoriesSchedulingTime:"required",
        },
        // Specify validation error messages
        messages: {
            PlatformId: "Please select platform name",
            PlatformLink: "Please enter your PlatformLink",
            MobileSpacesId: "Please select mobile space name",
            PostPerDay: "Please select posts plan",
            PostsQuantity: {
                required: "Please enter your post quantity",
                minlength: "Post quantity must be at least 1 numeric long",
                maxlength: "Post quantity must be at least 150 characters long",
                regex: "Only numerical values are allowed"
            },
            PostSchedulingTime: "Please select post scheduling time",
            StoriesPerDay: "Please select stories/status plan",
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
});