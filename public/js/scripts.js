$( document ).ready(function() {
    $('.selectpicker').selectpicker();
});

$( function() {
    'use strict';

    var $addForm = $('.add-form');
    var $bookTable = $('.book-table');
    var $errorsList = $('.errors-list');

    $addForm.on('submit', function (event) {
        event.preventDefault();
        var $this = $(this);
        $.ajax({
            url: $this.attr('action'),
            method: $this.attr('method'),
            data: $this.serialize(),
            dataType: 'html'
        }).success(function (data) {
            $errorsList.html('');
            $bookTable.html(data);
        }).fail(function (err) {
            $errorsList.html(err.responseText);
            console.log(err);
        })
    })
});