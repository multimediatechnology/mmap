// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require tether
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require dropzone
//= require turbolinks
//= require_tree .

Dropzone.autoDiscover = false

$(document).on('turbolinks:load', function () {

    // grap our upload form by its id
    $('.dropzone').dropzone({
        // restrict image size to a maximum 1GB
        maxFilesize: 1 * 1024,
        // max files (1)
        maxFiles: 1,
        // change default message
        dictDefaultMessage: 'Datei reinziehen oder klicken.',
        // changed the passed param to one accepted by
        // our rails app
        paramName: 'asset[file]',
        // show remove links on each image upload
        addRemoveLinks: false,
        // if the upload was successful
        success: function (file, response) {
            // find the remove button link of the uploaded file and give it an id
            // based of the fileID response from the server
            $(file.previewTemplate)
                .find('.dz-remove')
                .attr('id', response.fileID)
            // add the dz-success class (the green tick sign)
            $(file.previewElement)
                .addClass('dz-success')
            // replace table with list of files
            $('#files').html(response)
        },
        //when the remove button is clicked
        removedfile: function (file) {
            // grap the id of the uploaded file we set earlier
            const id = $(file.previewTemplate)
                .find('.dz-remove')
                .attr('id')

            // make a DELETE ajax request to delete the file
            $.ajax({
                type: 'DELETE',
                url: '/assets/' + id,
                success: function (data) {
                    console.log(data.message)
                }
            })
        }
    })
})
