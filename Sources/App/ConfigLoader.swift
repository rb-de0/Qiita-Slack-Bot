import Foundation
import Himotoki

class ConfigLoader {
    
    class func config() -> Config {
        
        let fileManager = FileManager()
        
        guard let projectPath = #file.components(separatedBy: "Sources/App/ConfigLoader").first else {
            fatalError("Illigal Error")
        }
        
        let configFilePath = projectPath + "/Config/config.json"
        
        if fileManager.fileExists(atPath: configFilePath),
            let data = NSData(contentsOfFile: configFilePath) {
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
                let config = try decodeValue(jsonObject) as Config
                return config
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        fatalError("Config FilePath Error")
    }
}
