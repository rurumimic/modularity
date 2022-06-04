module easytext.repository.example {
    requires easytext.repository.api;

    provides easytext.repository.api.TextRepository
        with easytext.repository.example.MyRepository;
}
