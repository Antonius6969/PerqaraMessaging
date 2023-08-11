//
//  LawyerMessagingVC.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation
import UIKit
import CoreMedia

class LawyerMessagingVC : UIViewController {
  
  @IBOutlet weak var ivBackMainChat: UIImageView!
  @IBOutlet weak var btnBackMainChat: UIButtonView!
  @IBOutlet weak var ivAdvocateWaitingRoom: UIImageView!
  @IBOutlet weak var lblNameAdvocateWaiting: UILabel!
  @IBOutlet weak var timeDurationMainChat: UILabel!
  @IBOutlet weak var ivStatusAdvocate: UIImageView!
  @IBOutlet weak var statusAdvocateMainChat: UILabel!
  @IBOutlet weak var btnFinishMainChat: UIButtonView!
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var ivSend: UIImageView!
  @IBOutlet weak var btnAttachment: UIButtonView!
  @IBOutlet weak var btnSendmsg: UIButtonView!
  @IBOutlet weak var messagesTableView: UITableView!
  @IBOutlet weak var imgAnimationWaiting: UIImageView!
  @IBOutlet weak var nameAdvocateMainChat: UILabel!
  @IBOutlet weak var lblTimeDownWaitingRoom: UILabel!
  @IBOutlet weak var viewChattingRoom: UIView!
  @IBOutlet weak var viewWaitingRoom: UIView!
  @IBOutlet weak var constraintTop: NSLayoutConstraint!  
  @IBOutlet weak var containerTextInput: UIView!
  @IBOutlet weak var ivAdvocateMainChat: UIImageView!
  
  
  struct VCProperty {
    static let storyBoardName : String = "Main"
    static let identifierVC : String = "LawyerMessagingVCIdentifier"
    static let constantHeightPopUp = 320
    static let constantAttachConfrim = 700
  }
  
  static let storyboardName = VCProperty.storyBoardName
  static let identifierVC = VCProperty.identifierVC
  
  var router : MessagingRouter?
  var vm = LawyerMessagingVM()
  var roomKey : String = ""
  var consultId : String = ""
  var clientId : String = ""
  var lawyerID : String = ""
  var timerWaiting:Timer?
  var timerRoom:Timer?
  
  var waitingLawyerAproveTime: Int = 180 //dalam detik
  var roomchatExpTime: Int = 1800 // dalam detik
  
  var chatMessageToMeTVCell = ChatMessageToMeTVCell()
  var chatMessageFromMeTVCell = ChatMessageFromMeTVCell()
  var messages : [MessagingReceiveListener] = []
  
  var isCameraPicker : Bool = true
  var cameraPicker = CameraPicker()
  var galeryPicker = GaleryPicker()
  var docPicker = DocumentPicker()
  var manager = FileManager.default
  var attachConfrimView = AttachConfrimView()
  var dataDoc : Data?
  
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
    self.navigationItem.setHidesBackButton(true, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupVM()
    setupRouter()
    setupView()
    setupAction()
    setupSocket()
  }
  
  func setupVM(){
    self.cameraPicker.delegate = self
    self.galeryPicker.delegate = self
    self.docPicker.delegate = self
    self.vm.delegateAttachmentService = self
  }
  
  func setupRouter(){
    self.router = MessagingRouter(viewController: self)
  }
  
  func setupView(){
    //    if self.firstlauch {
    //      firstlauch = false
    //      viewWaitingRoom.isHidden = false
    //      viewChattingRoom.isHidden = true
    //      setupViewWaiting()
    //    } else {
    //      viewWaitingRoom.isHidden = true
    //      viewChattingRoom.isHidden = false
    //      setupChat()
    //    }
    //    setUITableView()
    
    self.statusAdvocateMainChat.text = "Online"
    self.ivStatusAdvocate.image = UIImage(named: "ic_online")
    self.viewWaitingRoom.isHidden = true
    self.viewChattingRoom.isHidden = false
    self.setupChat()
  }
  
  func setupAction(){
    btnBackMainChat.setAtomic(type: .clear, title: "")
    self.btnBackMainChat.coreButton.addTapGestureRecognizer{
      self.navigationController?.popViewController(animated: true)
    }
    
// MARK :: Navigate to summary or rating
//    btnFinishMainChat.setAtomic(type: .nudeWhite, title: "Akhiri")
//    self.btnFinishMainChat.coreButton.addTapGestureRecognizer{
//      self.router?.navigateSummaryChatting(viewController: self, consultId: self.viewModel.consultId,roomKey: self.viewModel.roomKey)
//    }
    
    btnAttachment.setAtomic(type: .clear, title: "")
    self.btnAttachment.coreButton.addTapGestureRecognizer{
      let attachmentView = AttachmentView()
      attachmentView.setupView()
      attachmentView.delegate = self
      self.showPopUpBottomView(withView: attachmentView, height: CGFloat(VCProperty.constantHeightPopUp),isUseNavigationBar: false)
    }
    
    btnSendmsg.setAtomic(type: .clear, title: "")
    self.btnSendmsg.coreButton.addTapGestureRecognizer{
      // this is place for send message
      SocketConsultHelper.shared.socketChatSendText(data: self.vm.initMessageSendReq(message: self.messageTextField.text ?? ""))
      self.scrollToBottom(self.messagesTableView)
    }
  }
  
  func setupSocket(){
    //SocketConsultHelper.shared.delegateLawyerConsult = self
    SocketConsultHelper.shared.roomKey = self.roomKey
    SocketConsultHelper.shared.consultId = self.consultId
    SocketConsultHelper.shared.lawyerId = self.lawyerID
    SocketConsultHelper.shared.clientId = self.clientId
    SocketConsultHelper.shared.connectSocket { (success) in
        print("socket is connect")
        
    }
    //SocketConsultHelper.shared.socketChatConnect()
  }
}

extension LawyerMessagingVC {
  func setupChat(){
    ivAdvocateMainChat.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "img_placeholder"))
    ivAdvocateMainChat.roundCorners(value: 15)
    nameAdvocateMainChat.text = "client"// viewModel.advocate?.name
  }
  
  func scrollToBottom(_ tableView: UITableView) {
    let tableRows = tableView.numberOfRows(inSection: 0)
    if tableRows > 0
    {
      let lastMessageIndex = tableRows - 1
      let lastMessageIndexPath = IndexPath(row: lastMessageIndex, section: 0)
      tableView.scrollToRow(at: lastMessageIndexPath, at: .bottom, animated: true)
    }
  }
}
