module provider.factory.example {
    requires easytext.analysis.api;

    provides foo.easytext.analysis.api.Analyzer
        with foo.providers.factory.ExampleProviderFactory;
}
