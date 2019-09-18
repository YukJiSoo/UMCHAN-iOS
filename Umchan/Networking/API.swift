//  This file was automatically generated and should not be edited.

import Apollo

/// Input
public struct RegisterUserInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(email: String, password: String, name: String, nickname: String, location: LocationInput) {
    graphQLMap = ["email": email, "password": password, "name": name, "nickname": nickname, "location": location]
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var nickname: String {
    get {
      return graphQLMap["nickname"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nickname")
    }
  }

  public var location: LocationInput {
    get {
      return graphQLMap["location"] as! LocationInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "location")
    }
  }
}

/// Input
public struct LocationInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(latitude: Double, longitude: Double) {
    graphQLMap = ["latitude": latitude, "longitude": longitude]
  }

  public var latitude: Double {
    get {
      return graphQLMap["latitude"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "latitude")
    }
  }

  public var longitude: Double {
    get {
      return graphQLMap["longitude"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "longitude")
    }
  }
}

/// Input
public struct LoginInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(email: String, password: String) {
    graphQLMap = ["email": email, "password": password]
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }
}

/// Input
public struct CreateRunningInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(name: String, oneLine: String, runningDate: DateInput, registerLimitDate: DateInput, runningPoints: [LocationInput?]) {
    graphQLMap = ["name": name, "oneLine": oneLine, "runningDate": runningDate, "registerLimitDate": registerLimitDate, "runningPoints": runningPoints]
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var oneLine: String {
    get {
      return graphQLMap["oneLine"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "oneLine")
    }
  }

  public var runningDate: DateInput {
    get {
      return graphQLMap["runningDate"] as! DateInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "runningDate")
    }
  }

  public var registerLimitDate: DateInput {
    get {
      return graphQLMap["registerLimitDate"] as! DateInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "registerLimitDate")
    }
  }

  public var runningPoints: [LocationInput?] {
    get {
      return graphQLMap["runningPoints"] as! [LocationInput?]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "runningPoints")
    }
  }
}

public struct DateInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(year: Int, month: Int, date: Int, hour: Int, minute: Int) {
    graphQLMap = ["year": year, "month": month, "date": date, "hour": hour, "minute": minute]
  }

  public var year: Int {
    get {
      return graphQLMap["year"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "year")
    }
  }

  public var month: Int {
    get {
      return graphQLMap["month"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "month")
    }
  }

  public var date: Int {
    get {
      return graphQLMap["date"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var hour: Int {
    get {
      return graphQLMap["hour"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hour")
    }
  }

  public var minute: Int {
    get {
      return graphQLMap["minute"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "minute")
    }
  }
}

public final class RegisterUserMutation: GraphQLMutation {
  /// mutation RegisterUser($user: RegisterUserInput) {
  ///   register(user: $user) {
  ///     __typename
  ///     code
  ///     success
  ///     message
  ///     token
  ///   }
  /// }
  public let operationDefinition =
    "mutation RegisterUser($user: RegisterUserInput) { register(user: $user) { __typename code success message token } }"

  public let operationName = "RegisterUser"

  public var user: RegisterUserInput?

  public init(user: RegisterUserInput? = nil) {
    self.user = user
  }

  public var variables: GraphQLMap? {
    return ["user": user]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("register", arguments: ["user": GraphQLVariable("user")], type: .object(Register.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(register: Register? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "register": register.flatMap { (value: Register) -> ResultMap in value.resultMap }])
    }

    public var register: Register? {
      get {
        return (resultMap["register"] as? ResultMap).flatMap { Register(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "register")
      }
    }

    public struct Register: GraphQLSelectionSet {
      public static let possibleTypes = ["RegisterUserMutationResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, success: Bool, message: String, token: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "RegisterUserMutationResponse", "code": code, "success": success, "message": message, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}

public final class LoginMutation: GraphQLMutation {
  /// mutation Login($account: LoginInput!) {
  ///   login(account: $account) {
  ///     __typename
  ///     code
  ///     success
  ///     message
  ///     token
  ///     user {
  ///       __typename
  ///       id
  ///       name
  ///       nickname
  ///       imagePath
  ///       location {
  ///         __typename
  ///         latitude
  ///         longitude
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation Login($account: LoginInput!) { login(account: $account) { __typename code success message token user { __typename id name nickname imagePath location { __typename latitude longitude } } } }"

  public let operationName = "Login"

  public var account: LoginInput

  public init(account: LoginInput) {
    self.account = account
  }

  public var variables: GraphQLMap? {
    return ["account": account]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["account": GraphQLVariable("account")], type: .object(Login.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["LoginMutationResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .scalar(String.self)),
        GraphQLField("user", type: .object(User.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, success: Bool, message: String, token: String? = nil, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "LoginMutationResponse", "code": code, "success": success, "message": message, "token": token, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("nickname", type: .nonNull(.scalar(String.self))),
          GraphQLField("imagePath", type: .nonNull(.scalar(String.self))),
          GraphQLField("location", type: .nonNull(.object(Location.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String, nickname: String, imagePath: String, location: Location) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "nickname": nickname, "imagePath": imagePath, "location": location.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var nickname: String {
          get {
            return resultMap["nickname"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nickname")
          }
        }

        public var imagePath: String {
          get {
            return resultMap["imagePath"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "imagePath")
          }
        }

        public var location: Location {
          get {
            return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "location")
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
            GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(latitude: Double, longitude: Double) {
            self.init(unsafeResultMap: ["__typename": "Location", "latitude": latitude, "longitude": longitude])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var latitude: Double {
            get {
              return resultMap["latitude"]! as! Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "latitude")
            }
          }

          public var longitude: Double {
            get {
              return resultMap["longitude"]! as! Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "longitude")
            }
          }
        }
      }
    }
  }
}

public final class RunningListQuery: GraphQLQuery {
  /// query RunningList {
  ///   runnings {
  ///     __typename
  ///     code
  ///     success
  ///     message
  ///     runnings {
  ///       __typename
  ///       name
  ///       oneLine
  ///       runningDate {
  ///         __typename
  ///         year
  ///         month
  ///         date
  ///         hour
  ///         minute
  ///       }
  ///       registerLimitDate {
  ///         __typename
  ///         year
  ///         month
  ///         date
  ///         hour
  ///         minute
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query RunningList { runnings { __typename code success message runnings { __typename name oneLine runningDate { __typename year month date hour minute } registerLimitDate { __typename year month date hour minute } } } }"

  public let operationName = "RunningList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("runnings", type: .object(Running.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(runnings: Running? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "runnings": runnings.flatMap { (value: Running) -> ResultMap in value.resultMap }])
    }

    public var runnings: Running? {
      get {
        return (resultMap["runnings"] as? ResultMap).flatMap { Running(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "runnings")
      }
    }

    public struct Running: GraphQLSelectionSet {
      public static let possibleTypes = ["RunningsQueryResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
        GraphQLField("runnings", type: .list(.nonNull(.object(Running.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, success: Bool, message: String, runnings: [Running]? = nil) {
        self.init(unsafeResultMap: ["__typename": "RunningsQueryResponse", "code": code, "success": success, "message": message, "runnings": runnings.flatMap { (value: [Running]) -> [ResultMap] in value.map { (value: Running) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var runnings: [Running]? {
        get {
          return (resultMap["runnings"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Running] in value.map { (value: ResultMap) -> Running in Running(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Running]) -> [ResultMap] in value.map { (value: Running) -> ResultMap in value.resultMap } }, forKey: "runnings")
        }
      }

      public struct Running: GraphQLSelectionSet {
        public static let possibleTypes = ["Running"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("oneLine", type: .scalar(String.self)),
          GraphQLField("runningDate", type: .object(RunningDate.selections)),
          GraphQLField("registerLimitDate", type: .object(RegisterLimitDate.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, oneLine: String? = nil, runningDate: RunningDate? = nil, registerLimitDate: RegisterLimitDate? = nil) {
          self.init(unsafeResultMap: ["__typename": "Running", "name": name, "oneLine": oneLine, "runningDate": runningDate.flatMap { (value: RunningDate) -> ResultMap in value.resultMap }, "registerLimitDate": registerLimitDate.flatMap { (value: RegisterLimitDate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var oneLine: String? {
          get {
            return resultMap["oneLine"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "oneLine")
          }
        }

        public var runningDate: RunningDate? {
          get {
            return (resultMap["runningDate"] as? ResultMap).flatMap { RunningDate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "runningDate")
          }
        }

        public var registerLimitDate: RegisterLimitDate? {
          get {
            return (resultMap["registerLimitDate"] as? ResultMap).flatMap { RegisterLimitDate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "registerLimitDate")
          }
        }

        public struct RunningDate: GraphQLSelectionSet {
          public static let possibleTypes = ["Date"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("year", type: .scalar(Int.self)),
            GraphQLField("month", type: .scalar(Int.self)),
            GraphQLField("date", type: .scalar(Int.self)),
            GraphQLField("hour", type: .scalar(Int.self)),
            GraphQLField("minute", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(year: Int? = nil, month: Int? = nil, date: Int? = nil, hour: Int? = nil, minute: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Date", "year": year, "month": month, "date": date, "hour": hour, "minute": minute])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var year: Int? {
            get {
              return resultMap["year"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "year")
            }
          }

          public var month: Int? {
            get {
              return resultMap["month"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "month")
            }
          }

          public var date: Int? {
            get {
              return resultMap["date"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "date")
            }
          }

          public var hour: Int? {
            get {
              return resultMap["hour"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "hour")
            }
          }

          public var minute: Int? {
            get {
              return resultMap["minute"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "minute")
            }
          }
        }

        public struct RegisterLimitDate: GraphQLSelectionSet {
          public static let possibleTypes = ["Date"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("year", type: .scalar(Int.self)),
            GraphQLField("month", type: .scalar(Int.self)),
            GraphQLField("date", type: .scalar(Int.self)),
            GraphQLField("hour", type: .scalar(Int.self)),
            GraphQLField("minute", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(year: Int? = nil, month: Int? = nil, date: Int? = nil, hour: Int? = nil, minute: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Date", "year": year, "month": month, "date": date, "hour": hour, "minute": minute])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var year: Int? {
            get {
              return resultMap["year"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "year")
            }
          }

          public var month: Int? {
            get {
              return resultMap["month"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "month")
            }
          }

          public var date: Int? {
            get {
              return resultMap["date"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "date")
            }
          }

          public var hour: Int? {
            get {
              return resultMap["hour"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "hour")
            }
          }

          public var minute: Int? {
            get {
              return resultMap["minute"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "minute")
            }
          }
        }
      }
    }
  }
}

public final class CreateRunningMutation: GraphQLMutation {
  /// mutation CreateRunning($running: CreateRunningInput) {
  ///   createRunning(running: $running) {
  ///     __typename
  ///     code
  ///     success
  ///     message
  ///   }
  /// }
  public let operationDefinition =
    "mutation CreateRunning($running: CreateRunningInput) { createRunning(running: $running) { __typename code success message } }"

  public let operationName = "CreateRunning"

  public var running: CreateRunningInput?

  public init(running: CreateRunningInput? = nil) {
    self.running = running
  }

  public var variables: GraphQLMap? {
    return ["running": running]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createRunning", arguments: ["running": GraphQLVariable("running")], type: .object(CreateRunning.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createRunning: CreateRunning? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createRunning": createRunning.flatMap { (value: CreateRunning) -> ResultMap in value.resultMap }])
    }

    public var createRunning: CreateRunning? {
      get {
        return (resultMap["createRunning"] as? ResultMap).flatMap { CreateRunning(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createRunning")
      }
    }

    public struct CreateRunning: GraphQLSelectionSet {
      public static let possibleTypes = ["CreateRunningMutationResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, success: Bool, message: String) {
        self.init(unsafeResultMap: ["__typename": "CreateRunningMutationResponse", "code": code, "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}
