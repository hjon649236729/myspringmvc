package hjon.company.common.utils.exception;

public class AuditException extends RuntimeException {

	  private static final long serialVersionUID = 1L;

	  public AuditException() {
	    super();
	  }
	  public AuditException(String msg, Throwable cause) {
	    super(msg);
	    super.initCause(cause);
	  }
	  public AuditException(String msg) {
	    super(msg);
	  }
	  public AuditException(Throwable cause) {
	    super();
	    super.initCause(cause);
	  }
	}


