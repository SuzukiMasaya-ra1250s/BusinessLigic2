import Foundation
import PlaygroundSupport

class MicroWaveOvenLogic {
    // レンジ初期設定
    var isPowerOn: Bool = false // 電源状態
    var isEmission: Bool = false // レンジ動作状態
    var isPowerButton: Bool = false  // 電源ボタンTap状態
    var isStartButton: Bool = false  // StartボタンTap状態
    var isDoorOpen: Bool = false   // ドア開閉状態
    var isPower1500: Bool = false  // レンジ出力(1500W, 通常500W)
    // タイマー初期設定
    var setTimerLevel: Int = 0  // タイマー設定レベル
    var settingTime: Int = 0 // タイマー設定時間
    var remainingTime: Int = 0 // タイマー残時間
    var endTime: Int = 0 // タイマー終了時間
    var timer: Timer?
    // 動作確認用(実行時に各パラメータに直接書き込みせずに、一旦設定値受け渡し用の変数、メソッドを使う)
    var inputPowerButton: Bool = false // 電源ボタン
    var inputStartButton: Bool = false // スタートボタン
    var inputDooOpen: Bool = false // ドア開閉
    var inputPower1500: Bool = false // レンジ出力
    var inputTimerLevel: Int = 0 // タイマー設定
    
    // タイマー設定
    func count() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true
        )
        remainingTime = settingTime // タイマー設定時間をタイマー残時間に設定（代入）
    }
    // タイマー動作
    @objc func countDown() {
        remainingTime -= 1  // 1秒毎カウントダウン
        remainingTimeDisplay() // タイマーディスプレイ表示呼び出し
        if endTime >= remainingTime {
            endOven()
            timer?.invalidate() // タイマー停止
        }
    }
    // 電源ボタン
    func tapPowerButton() {
        if !isPowerOn { // 電源オフの場合は、電源オンメソッドを呼び出す
            onPower()
        } else {
            offPower() // 電源オンの場合は、電源オフメソッドを呼び出す
        }
    }
    // レンジタイマー設定
    func setOven() {
        switch setTimerLevel {
        case 1:
            settingTime = 5
        case 2:
            settingTime = 10
        case 3:
            settingTime = 15
        case 4:
            settingTime = 20
        default:
            buzzer()
        }
        print("🕰️タイマー設定：\(settingTime)秒")
    }
    // 電源オン
    func onPower() {
        isPowerOn = true
        if isPowerOn { // 状態確認してオン出力
            print("💡レンジ電源オン")
        }
        setOven() // タイマー設定メソッド呼び出し
    }
    // 電源オフ
    func offPower() {
        isPowerOn = false
        if !isPowerOn { // 状態確認してオフなら出力
            print("💡レンジ電源オフ")
        }
    }
    // スタートボタン
    func tapStartButton() {
        var isStartOven = false
        isStartOven = isPowerOn && isStartButton && !isDoorOpen && settingTime > 0 // スタート条件：スタートボタン＆電源オン＆ドア閉扉＆タイマー時間設定あり(0より大きい)
        if isStartOven { // trueならレンジ始動メソッド呼び出し
            startOven()
        }
    }
    // レンジ始動
    func startOven() {
        isEmission = true // レンジ動作状態をtrueに変更
        count()
        print("⚡️電磁波発射")
    }
    // レンジ終了
    func endOven() {
        isEmission = false // レンジ動作状態をfalseに変更
        print("⚡️電磁波停止")
        buzzer() // ブザー鳴動メソッド呼び出し
    }
    // タイマーディスプレイ表示
    func remainingTimeDisplay() {
        print("⏳:\(remainingTime)秒") // ディスプレイに残時間を表示
    }
    // ブザー鳴動
    func buzzer() {
        print("🔔 ビープ音:鳴って→止まる")
    }
    // 動作確認用メソッド(操作設定をこのメソッドを通して書き込む)
    func operationTest(inputPowerButton: Bool, inputStartButton: Bool, inputDooOpen: Bool, inputPower1500: Bool, inputTimeLevel: Int) {
        isPowerOn = inputPowerButton
        isPowerButton = inputPowerButton
        isStartButton = inputStartButton
        isDoorOpen = inputDooOpen
        isPower1500 = inputPower1500
        setTimerLevel = inputTimeLevel
        tapPowerButton()
        tapStartButton()
    }
}

let microWaveOvenLogic = MicroWaveOvenLogic()
microWaveOvenLogic.operationTest(inputPowerButton: false, inputStartButton: true, inputDooOpen: false , inputPower1500: false, inputTimeLevel: 2)

