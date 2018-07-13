package bdlab;

import java.sql.PreparedStatement;

public interface Query {
	void prepareQuery(PreparedStatement ps) throws Exception;
}
