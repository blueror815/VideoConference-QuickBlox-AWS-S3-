var ready;
ready = function() {
    var engine = new Bloodhound({
        datumTokenizer: function(d) {
            console.log(d);
            return Bloodhound.tokenizers.whitespace(d.title);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '../institutions/autocomplete?query=%QUERY'
        }
    });

    var promise = engine.initialize();

    promise
        .done(function() { console.log('success') })
        .fail(function() { console.log('err') });

    $('.form-control typeahead').typeahead(null, {
        name: 'engine',
        displayKey: 'title',
        source: engine.ttAdapter()
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
