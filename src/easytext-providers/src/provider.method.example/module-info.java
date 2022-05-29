module provider.method.example {
    requires easytext.analysis.api;

    provides foo.easytext.analysis.api.Analyzer
        with foo.providers.method.ExampleProviderMethod;
}
