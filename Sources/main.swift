import CAVFormat

extension FailureMessage {
    static let badArguments = FailureMessage(exitCode: 1, message: "Usage: extractor filename")
    static let openFailed = FailureMessage(exitCode: 2, message: "could not open input file")
}

guard let fileName = CommandLine.arguments[safe: 1] else { fail(.badArguments) }

av_register_all()

var contextPointer = avformat_alloc_context()

fileName.withCString {
    let ret = avformat_open_input(&contextPointer, $0, nil, nil)
    if ret != 0 { fail(.openFailed) }
}

let context = contextPointer!.pointee

for c in UnsafeBufferPointer(start: context.chapters, count: Int(context.nb_chapters)) {
    let chapter = c!.pointee
    print(chapter)

    let entry = av_dict_get(chapter.metadata, "title", nil, 0)
    let name = String(cString: entry!.pointee.value, encoding: .utf8)!
    print(name)
}
