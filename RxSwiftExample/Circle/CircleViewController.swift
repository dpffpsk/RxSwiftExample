//
//  CircleViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/05/31.
//

import UIKit
import RxSwift
import RxCocoa

/*
 Subject - Observable과 Observer를 한꺼번에 부르는 용어입니다. 기본적으로 관찰할 수도, 관찰당할 수도 있습니다.
 BehaviorSubject - 구독하면 Subject에 의해 반환한 가장 최근 값을 가져오고, 구독 이후에 반환하는 값을 가져옵니다.
 PublishSubject - 구독하면 구독 이후에 반환하는 값을 얻게됩니다.
 ReplaySubject - 구독하면 구독 이후에 반환하는 값뿐만 아니라, 구독 이전에 반환한 값을 가져옵니다. 구독하는 ReplaySubject의 버퍼 사이즈 만큼의 이전 값을 가져옵니다. 그리고 그 버퍼 사이즈는 Subject의 초기화할 때 알 수 있습니다.
 */
class CircleViewController: UIViewController {

    var circleView: UIView!
    let circleViewModel = CircleViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupBinding()
        
        // 제스처 추가
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }

    func setup() {
        // 원 모양의 뷰를 그린다.
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)
    }
    
    @objc func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        // 이동 위치를 가져와 원의 중심 좌표로 지정해준다.
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
    
    func setupBinding() {
        // Observer(송신)
        // 원의 중앙 위치 값을 관찰한다.(원에서 새로운 위치 값이 반환되는 것을 관찰.)
        // bind : 값을 넘겨줄 때 사용
        circleView.rx.observe(CGPoint.self, "center")
//            .filter{ $0 != nil }
            .map{ $0! } // 이 코드가 없이 bind를 사용할 시 오류가 난다. optional 체크를 하지 않았기때문이다.
            .bind(to: circleViewModel.centerObservable)
            .disposed(by: disposeBag)
        
        
        // Observer -> Observable 발생된 이벤트 다룬다.
        // subscribe : 한 대상이 있고 subscribe를 하고 있을 때, 그 대상의 상태가 변하면 그 값을 받아 와서 처리할 수 있게한다.
        circleViewModel.backgroundColorObservable.subscribe { [weak self] backgroundColor in
            UIView.animate(withDuration: 0.1) {
                // 원 색 바꾸기
                self?.circleView.backgroundColor = backgroundColor
                
                let r = backgroundColor.components.red
                let g = backgroundColor.components.green
                let b = backgroundColor.components.blue
                
                // truncatingRemainder(dividingBy:) : 소수점이 있는 Double, Float의 나머지 값
                let viewBackgroundColor: UIColor = UIColor.init(red: 1-r.truncatingRemainder(dividingBy: 0.4), green: 1-g.truncatingRemainder(dividingBy: 0.4), blue: 1-b.truncatingRemainder(dividingBy: 0.4), alpha: 1.0)
                
                if backgroundColor != viewBackgroundColor {
                    // 배경화면 색 바꾸기
                    self?.view.backgroundColor = viewBackgroundColor
                }
            }
        }.disposed(by: disposeBag)
    }
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    //UIColor에서 rgb값 뽑아내기
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}
