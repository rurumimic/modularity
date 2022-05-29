module easytext.analysis.coleman {
    requires easytext.analysis.api;
    provides foo.easytext.analysis.api.Analyzer
        with foo.easytext.analysis.coleman.Coleman;
}
