define([], function () {
    var configLocal = {};

    configLocal.api = {
        name: 'OHDSI',
        // TODO Update host + port below
        url: 'http://localhost:8080/WebAPI/'
    };

    return configLocal;
});