////
////  ContentView.swift
////  FoxusApp
////
////  Created by AlJawharh AlOtaibi on 20/05/1445 AH.
//
//
//import SwiftUI
//import CoreData
////
////
////// Core Data Task Entity
////class TaskEntity: NSManagedObject {
////    @NSManaged var id: UUID
////    @NSManaged var taskName: String
////    @NSManaged var taskTime: Date
////    @NSManaged var taskPriority: String
////}
////
////enum Priority: String, CaseIterable {  
////    case low = "Low"
////    case med = "     Medium"
////    case high = "High"
////    case extreme = "      Extreme"
////
////    var color: Color {
////        switch self {
////        case .low:
////            return Color.yellow
////        case .med:
////            return Color.orange
////        case .high:
////            return Color.red
////        case .extreme:
////            return Color(red: 0.6, green: 0.0, blue: 0.0)
////        }
////    }
////    var Bordercolor: Color {
////            switch self {
////            case .low:
////                return .yellow
////            case .med:
////                return .orange
////            case .high:
////                return .red
////            case .extreme:
////                return Color(red: 0.6, green: 0.0, blue: 0.0)
////            }
////        }
////
////}
//
//
////struct ContentView: View {
////    @Environment(\.managedObjectContext) private var viewContext
//////    @FetchRequest(entity: TaskEntity.entity(), sortDescriptors: []) var tasks: FetchedResults<TaskEntity>
//////
////    
////    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
////    @State private var isShowingSheet = false
////    @State var selection: Int = 0
////    var greeting: String {
////            return greetingByTime()
////        }
//  //  @Environment(\.colorScheme) var colorScheme
//
//    var body: some View {
//        Text("")
//       // .background(colorScheme == .dark ? Color.bg : Color.white)
//
//        
////        NavigationView {
////            VStack {
////                
////                //NewR
////                Picker("Choose a side",selection: $selection ) {
////                    Text("Upcoming").tag(0)
////                    Text("Completed").tag(1)
////                }.padding(0).padding()
////                    .pickerStyle(SegmentedPickerStyle())
////                    .padding(.top, 10)
////                
////             
////                if(selection == 0){
////                    List(tasks.filter{$0.staus == false}) { task in
////                        TaskCardView(task: $task, priority: task.priority)
////                    }
//////                            List(tasks.filter{$0.staus ==  false}) { task in
//////
//////                            }
////                }
////                else{
////                    List(tasks.filter{$0.staus ==  false}) { task in
////                        TaskCardView(task: task, priority: task.priority)
////                    }
////
////                }
////                //NewR
////                
////                List {
////                    ForEach(tasks, id: \.id) { task in
////                        TaskCardView(task: task)
////                    }
////                }
////                .listStyle(InsetGroupedListStyle())
////
////                Button(action: {
////                    isShowingSheet = true
////                }) {
////                    Text("New Task")
////                        .font(.headline)
////                        .frame(width: 300, height: 50)
////                        .foregroundColor(.white)
////                        .background(Color.customColor)
////                        .cornerRadius(10)
////                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
////                }
////                .padding()
////                .sheet(isPresented: $isShowingSheet) {
////                    TaskInputSheet(isPresented: $isShowingSheet, viewContext: viewContext)
////                }
////            }
////            
////            .navigationBarTitle(greeting)
////    }
//}
//
////func greetingByTime() -> String {
////            let currentDate = Date()
////            let calendar = Calendar.current
////            let currentHour = calendar.component(.hour, from: currentDate)
////            
////            if 5 <= currentHour && currentHour < 12 {
////                return "Good morning,"
////            } else if 12 <= currentHour && currentHour < 18 {
////                return "Good afternoon,"
////            } else {
////                return "Good evening,"
////            }
////        }
////    }
////struct TaskInputSheet: View {
////    @Binding var isPresented: Bool
////    @State private var taskName = ""
////    @State private var taskTime = Date()
////    @State private var selectedPriority: Priority = .low
////    @State private var showErrorAlert = false
////    @State private var errorMessage = ""
////    
////    let viewContext: NSManagedObjectContext
////    
////    init(isPresented: Binding<Bool>, viewContext: NSManagedObjectContext) {
////        self._isPresented = isPresented
////        self.viewContext = viewContext
////    }
////    
////    var body: some View {
////        NavigationView {
////            Form {
////                Section(header: Text("Task Details")) {
////                    TextField("Task Name", text: $taskName)
////                    DatePicker("Time", selection: $taskTime, displayedComponents: .hourAndMinute)
////                    VStack(alignment: .leading, spacing: 10) {
////                        ForEach(Priority.allCases.chunked(into: 2), id: \.self) { prioritiesRow in
////                            HStack(spacing: 20) {
////                                ForEach(prioritiesRow, id: \.self) { priority in
////                                    Button(action: {
////                                        selectedPriority = priority
////                                    }) {
////                                        HStack {
////                                            ZStack {
////                                                RoundedRectangle(cornerRadius: 10)
////                                                    .stroke(selectedPriority == priority ? priority.color : Color.gray.opacity(0.3), lineWidth: 2)
////                                                    .background(
////                                                        RoundedRectangle(cornerRadius: 10)
////                                                            .fill(selectedPriority == priority ? priority.color : Color.white)
////                                                    )
////                                                    .frame(width: 100, height: 50)
////                                                    .overlay(
////                                                        Circle()
////                                                            .fill(priority.color)
////                                                            .frame(width: 20, height: 20)
////                                                            .offset(x: -35)
////                                                    )
////                                                    .overlay(
////                                                        Text(priority.rawValue)
////                                                            .foregroundColor(selectedPriority == priority ? .white : .black)
////                                                    )
////                                            }
////                                        }
////                                    }
////                                    .buttonStyle(PlainButtonStyle())
////                                }
////                            }
////                        }
////                    }
////                }
////                
////                Section {
////                    Button(action: {
////                        if areFieldsValid() {
////                            saveTask()
////                            isPresented = false
////                        } else {
////                            showErrorAlert = true
////                        }
////                    }) {
////                        Text("Save Task")
////                            .font(.headline)
////                            .frame(width: 300, height: 50)
////                            .foregroundColor(.white)
////                            .background(Color.customColor)
////                            .cornerRadius(10)
////                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
////                    }
////                }
////            }
////            .navigationBarTitle("New Task")
////            .navigationBarItems(trailing: Button("Close") {
////                isPresented = false
////            })
////            .alert(isPresented: $showErrorAlert) {
////                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
////            }
////        }
////    }
////    
////    private func areFieldsValid() -> Bool {
////        if taskName.isEmpty || selectedPriority == nil {
////            errorMessage = "Please fill in all the mandatory fields."
////            return false
////        }
////        return true
////    }
////    
////   
////    
////    private func saveTask() {
////        let newTask = Task(context: viewContext)
////       // newTask.id = UUID()
////        newTask.name = taskName
////        newTask.time = taskTime
////        newTask.priority = selectedPriority.rawValue
////
////        do {
////            try viewContext.save()
////        } catch {
////            let nsError = error as NSError
////            fatalError("Error saving new task: \(nsError), \(nsError.userInfo)")
////        }
////        
//////        let newTask = TaskEntity(context: viewContext)
//////        newTask.id = UUID()
//////        newTask.taskName = taskName
//////        newTask.taskTime = taskTime
//////        newTask.taskPriority = selectedPriority.rawValue
//////
//////        do {
//////            try viewContext.save()
//////        } catch {
//////            let nsError = error as NSError
//////            fatalError("Error saving new task: \(nsError), \(nsError.userInfo)")
//////        }
////    }
////}
////struct OneSideBorderShape: Shape {
////    func path(in rect: CGRect) -> Path {
////        var path = Path()
////        
////        // Add a path for the left side of the rect
////        let leftSide = CGRect(x: rect.minX, y: rect.minY, width: 5, height: rect.height)
////        path.addRect(leftSide)
////    
////        return path
////    }
////}
//
//
////struct TaskCardView: View {
////    var task: Task
////
//////    var task: TaskEntity
////    var body: some View {
////        VStack(alignment: .leading) {
////            Text("Name: \(task.name ?? "")")
////            Text("Time: \(formattedTime(task.time!))")
////            Text("Priority: \(task.priority!)")
////        }
////        .padding()
////        .background(Color.gray.opacity(0.1))
////        
////        //NewR
////        .overlay(OneSideBorderShape().stroke(priority.Bordercolor, lineWidth: 5))
////        .cornerRadius(15)
////        .padding([.horizontal, .bottom])
////        
////        //NewR
////        Button(action: {
////            
////            task.staus.toggle()
////            
////            
////        }) {
////            
////            
////            
////            //   Text("DONE!")
////        }
////        .buttonStyle(CheckboxStyle(isChecked: $task.staus))
////    }
////
////    private func formattedTime(_ time: Date) -> String {
////        let formatter = DateFormatter()
////        formatter.dateStyle = .short
////        formatter.timeStyle = .short
////        return formatter.string(from: time)
////    }
////}
////NewR
////struct CheckboxStyle: ButtonStyle {
////    @Binding var isChecked: Bool
////
////    func makeBody(configuration: Configuration) -> some View {
////        return HStack {
////            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
////                .foregroundColor(isChecked ? .blue : .secondary)
////            configuration.label
////        }
////    }
////}
////
////extension Array {
////    func chunked(into size: Int) -> [[Element]] {
////        stride(from: 0, to: count, by: size).map {
////            Array(self[$0 ..< Swift.min($0 + size, count)])
////        }
////    }
////}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//
//
