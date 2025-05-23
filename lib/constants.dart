// constants.dart
// В этом файле хранятся константы, используемые при формировании запроса для генерации сценария

const String kScenarioPrompt =
    // Шаблон запроса для генерации сценария
    "You have to generate scenario for the {platform} short video. "
    "The theme of the video is {videoTheme}. Target audience is {targetAudience}. "
    "The length of the video should be {videoLength} seconds. "
    "The style of content is {contentStyle}. "
    "And in the end you should call for the action: {callToAction}. "
    // Указываем, в каком формате должен быть возвращён результат: JSON с полями title и body
    "Return result in form of json with the following fields: title, body. Title and body are strings.";
