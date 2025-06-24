import java.util.UUID;

class Element {
  // Private properties (system-assigned)
  String id;
  int level;
  int size;
  int maxChildren;
  String state;
  String createdAt;
  
  // Feedback system (can be used later for adaptive behavior)
  HashMap<String, Float> feedbackSignals;

  // Public properties (user-defined)
  String label;
  String type;
  String description;
  String[] tags;
  HashMap<String, String> config;

  // Derived properties (auto-generated)
  String category;
  String platform;
  String icon;
  String riskLevel;

  // Children
  ArrayList<Element> children;

  Element(String label, String type, int level) {
    this.id = UUID.randomUUID().toString();
    this.level = level;
    this.state = "active";
    this.createdAt = year() + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "T" + nf(hour(), 2) + ":" + nf(minute(), 2);
    this.maxChildren = max(0, 6 - 2 * level);
    this.label = label;
    this.type = type;
    this.description = "";
    this.tags = new String[0];
    this.config = new HashMap<String, String>();
    this.feedbackSignals = new HashMap<String, Float>();
    this.children = new ArrayList<Element>();
    this.size = 1;
  }

  void addChild(Element child) {
    if (children.size() < maxChildren) {
      children.add(child);
      size++;
    }
  }

  void computeDerived() {
    // Simple inference
    if (config.containsKey("technology")) {
      platform = config.get("technology");
    } else {
      platform = "Unknown";
    }

    if (type.equals("service")) {
      category = "Data Exporter";
      icon = "file-export";
    } else {
      category = "Uncategorized";
      icon = "block";
    }

    riskLevel = "low"; // Placeholder, can be computed later
  }
}

Element root;

void setup() {
  size(800, 600);
  root = new Element("Falcon Data Replicator", "service", 0);
  root.description = "Exports telemetry to S3";
  root.config.put("technology", "AWS");
  root.tags = new String[] { "CrowdStrike", "AWS", "FDR" };
  root.computeDerived();

  // Add a few children
  Element child1 = new Element("S3 Bucket", "component", 1);
  Element child2 = new Element("IAM Role", "component", 1);
  root.addChild(child1);
  root.addChild(child2);

  // Example nested level
  Element grandchild = new Element("Policy", "config", 2);
  child1.addChild(grandchild);
}

void draw() {
  background(240);
  drawElement(root, 100, 100);
}

void drawElement(Element e, float x, float y) {
  fill(255);
  stroke(0);
  rect(x, y, 180, 60);
  fill(0);
  textAlign(LEFT, TOP);
  text(e.label + "\n" + e.type + "\n" + "Children: " + e.children.size(), x + 8, y + 8);

  // Draw children below
  float childY = y + 80;
  for (Element child : e.children) {
    drawElement(child, x + 40, childY);
    childY += 100;
  }
}
