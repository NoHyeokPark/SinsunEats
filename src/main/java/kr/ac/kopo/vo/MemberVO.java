package kr.ac.kopo.vo;

public class MemberVO {
	private String id;
	private String name;
	private String password;
	private String emailId;
	private String emailDomain;
	private String tel1;
	private String tel2;
	private String tel3;
	private String post;
	private String basicAddr;
	private String detailAddr;
	private String type;
	private String regDate;
	
	public MemberVO() {
		// TODO Auto-generated constructor stub
	}

	public MemberVO(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}

	public MemberVO(String id, String name, String password, String emailId, String emailDomain, String tel1,
			String tel2, String tel3, String post, String basicAddr, String detailAddr) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.emailId = emailId;
		this.emailDomain = emailDomain;
		this.tel1 = tel1;
		this.tel2 = tel2;
		this.tel3 = tel3;
		this.post = post;
		this.basicAddr = basicAddr;
		this.detailAddr = detailAddr;
	}

	public MemberVO(String id, String name, String password, String emailId, String emailDomain, String tel1,
			String tel2, String tel3, String post, String basicAddr, String detailAddr, String type, String regDate) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.emailId = emailId;
		this.emailDomain = emailDomain;
		this.tel1 = tel1;
		this.tel2 = tel2;
		this.tel3 = tel3;
		this.post = post;
		this.basicAddr = basicAddr;
		this.detailAddr = detailAddr;
		this.type = type;
		this.regDate = regDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getEmailDomain() {
		return emailDomain;
	}

	public void setEmailDomain(String emailDomain) {
		this.emailDomain = emailDomain;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getBasicAddr() {
		return basicAddr;
	}

	public void setBasicAddr(String basicAddr) {
		this.basicAddr = basicAddr;
	}

	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

}
