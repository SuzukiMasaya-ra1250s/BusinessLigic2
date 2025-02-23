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
    var settingTime: Int = 5 // タイマー設定時間
    var remainingTime: Int = 0 // タイマー残時間
    var endTime: Int = 0 // タイマー終了時間
    var timer: Timer?
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
    // レンジ設定
    func setOven() {
        
    }
    
    
    // 電源オン
    func onPower() {
        isPowerOn = true
        if isPowerOn { // 状態確認してオン出力
            print("💡レンジ電源オン")
        }
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
        isStartOven = isPowerOn && !isDoorOpen && settingTime > 0 // スタート条件：電源オン＆ドア閉扉＆タイマー時間設定あり(0より大きい)
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
}

let microWaveOvenLogic = MicroWaveOvenLogic()
microWaveOvenLogic.tapPowerButton()


