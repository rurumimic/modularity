module easytext.analysis.kincaid {
    requires easytext.analysis.api;
    provides foo.easytext.analysis.api.Analyzer
        with foo.easytext.analysis.kincaid.FleschKincaid;
}
