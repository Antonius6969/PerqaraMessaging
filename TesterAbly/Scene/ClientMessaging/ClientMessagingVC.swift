//
//  ClientMessagingVC.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation
import UIKit
import SocketIO
import CoreMedia
import SDWebImage

class ClientMessagingVC : UIViewController {
  
  @IBOutlet weak var viewWaitingRoom: UIView!
  @IBOutlet weak var imgAnimationWaiting: UIImageView!
  @IBOutlet weak var ivAdvocateWaitingRoom: UIImageView!
  @IBOutlet weak var lblNameAdvocateWaiting: UILabel!
  @IBOutlet weak var lblTimeDownWaitingRoom: UILabel!
  
  @IBOutlet weak var viewChattingRoom: UIView!
  @IBOutlet weak var ivStatusAdvocate: UIImageView!
  @IBOutlet weak var constraintTop: NSLayoutConstraint!
  @IBOutlet weak var ivBackMainChat: UIImageView!
  @IBOutlet weak var btnBackMainChat: UIButtonView!
  
  @IBOutlet weak var ivAdvocateMainChat: UIImageView!
  @IBOutlet weak var nameAdvocateMainChat: UILabel!
  @IBOutlet weak var statusAdvocateMainChat: UILabel!
  @IBOutlet weak var timeDurationMainChat: UILabel!
  @IBOutlet weak var btnFinishMainChat: UIButtonView!
  @IBOutlet weak var containerTextInput: UIView!
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var messagesTableView: UITableView!
  
  @IBOutlet weak var ivSend: UIImageView!
  @IBOutlet weak var btnAttachment: UIButtonView!
  @IBOutlet weak var btnSendmsg: UIButtonView!
  
  struct VCProperty {
    static let storyBoardName : String = "Main"
    static let identifierVC : String = "ClientMessagingVCIdentifier"
    static let constantHeightPopUp = 375
    static let constantAttachConfrim = 700
  }
  
  static let storyboardName = VCProperty.storyBoardName
  static let identifierVC = VCProperty.identifierVC
  
  var router : MessagingRouter?
  var vm = ClientMessagingVM()
  
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
    setUITableView()
  }
  
  func setupAction(){
    btnBackMainChat.setAtomic(type: .clear, title: "")
    self.btnBackMainChat.coreButton.addTapGestureRecognizer{
      self.navigationController?.popViewController(animated: true)
    }
    
    //MARK :: Navigate to summary or rating
    btnFinishMainChat.setAtomic(type: .nudeWhite, title: "Akhiri")
    self.btnFinishMainChat.coreButton.addTapGestureRecognizer{
      self.navigationController?.popViewController(animated: true)
      //self.router?.navigateSummaryChatting(viewController: self, consultId: self.viewModel.consultId,roomKey: self.viewModel.roomKey)
    }
    
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
      self.messageTextField.text = ""
      self.scrollToBottom(self.messagesTableView)
    }
  }
  
  func setupSocket(){
    SocketConsultHelper.shared.delegateChatConsult = self
    SocketConsultHelper.shared.delegateClientConsult = self
    SocketConsultHelper.shared.roomKey = self.vm.roomKey
    SocketConsultHelper.shared.consultId = self.vm.consultId
    SocketConsultHelper.shared.lawyerId = self.vm.lawyerID
    SocketConsultHelper.shared.clientId = self.vm.clientId
    
    SocketConsultHelper.shared.connectSocket { (success) in
      print("socket is connect")
    }
    SocketConsultHelper.shared.socketChatConnect()
  }
}

extension ClientMessagingVC {
  func setupChat(){
    ivAdvocateMainChat.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "img_placeholder"))
    ivAdvocateMainChat.roundCorners(value: 15)
    nameAdvocateMainChat.text = vm.lawyerName// viewModel.advocate?.name
  }
  
  func setupTableViewCell(){
    let nibChatMessageToMe = UINib(nibName: ChatMessageToMeTVCell.nibName, bundle: nil)
    self.messagesTableView.register(nibChatMessageToMe, forCellReuseIdentifier: ChatMessageToMeTVCell.identifier)
    
    let nibChatMessageFromMe = UINib(nibName: ChatMessageFromMeTVCell.nibName, bundle: nil)
    self.messagesTableView.register(nibChatMessageFromMe, forCellReuseIdentifier: ChatMessageFromMeTVCell.identifier)
    
    let nibChatAttachmentToMeTVCell = UINib(nibName: ChatAttachmentToMeTVCell.nibName, bundle: nil)
    self.messagesTableView.register(nibChatAttachmentToMeTVCell, forCellReuseIdentifier: ChatAttachmentToMeTVCell.identifier)
    
    let nibChatAttachmentFromMeTVCell = UINib(nibName: ChatAttachmentFromMeTVCell.nibName, bundle: nil)
    self.messagesTableView.register(nibChatAttachmentFromMeTVCell, forCellReuseIdentifier: ChatAttachmentFromMeTVCell.identifier)
    
    let nibPresenceChatMessage = UINib(nibName: PresenceChatMessageTVCell.nibName, bundle: nil)
    self.messagesTableView.register(nibPresenceChatMessage, forCellReuseIdentifier: PresenceChatMessageTVCell.identifier)
  }
  
  func setUITableView(){
    self.messagesTableView.showsVerticalScrollIndicator = true
    self.messagesTableView.allowsSelection = false
    self.messagesTableView.separatorStyle = .none
    setupTableView()
  }
  
  func setupTableView(){
    self.setupTableViewCell()
    self.messagesTableView.delegate = self
    self.messagesTableView.dataSource = self
    self.messagesTableView.backgroundView = UIImageView(image: UIImage(named: "img_chat_bckg"))
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
